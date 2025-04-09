#!/bin/bash

# Improved Backport Script
# Usage: ./backport.sh BRANCH_NAME

# Constants
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROGRESS_FILE="$SCRIPT_DIR/.backport_progress"

if [ $# -eq 0 ]; then
  echo "Error: Please provide a branch name to backport from."
  echo "Usage: ./backport.sh BRANCH_NAME"
  exit 1
fi

# The branch to backport from
BACKPORT_BRANCH=$1

# Store the current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $CURRENT_BRANCH"
echo "Backporting from branch: $BACKPORT_BRANCH"

# Check if we're in the middle of a cherry-pick
if git rev-parse --verify CHERRY_PICK_HEAD >/dev/null 2>&1; then
  echo "Detected ongoing cherry-pick operation."
  echo "Please complete it with 'git cherry-pick --continue' or abort with 'git cherry-pick --abort'"
  echo "Then run this script again."
  exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "You have uncommitted changes. Stashing them for safety..."
  git stash save "Automatic stash by backport script"
  CHANGES_STASHED=true
else
  CHANGES_STASHED=false
fi

# Function to extract version from configure.in
get_version() {
  local branch=$1
  local repo_root=$(git rev-parse --show-toplevel)
  local configure_in="$repo_root/ie/configure.in"
  
  # Temporarily checkout the branch to check its version
  git checkout -q $branch
  
  # Extract version if configure.in exists
  if [ -f "$configure_in" ]; then
    VERSION=$(grep -oP 'AC_INIT\([^)]*\)' $configure_in | sed -E 's/.*,([^,]+),.*/\1/')
    VERSION=$(echo $VERSION | tr -d ' ')
    echo $VERSION
  else
    echo "unknown"
  fi
}

# Make sure both branches are up to date
echo "Updating branches..."
git fetch origin $CURRENT_BRANCH $BACKPORT_BRANCH

# Get versions from both branches
echo "Getting version information..."
BACKPORT_VERSION=$(get_version $BACKPORT_BRANCH)
CURRENT_VERSION=$(get_version $CURRENT_BRANCH)

# Go back to our original branch
git checkout -q $CURRENT_BRANCH

echo "Backport branch version: v$BACKPORT_VERSION"
echo "Current branch version: v$CURRENT_VERSION"

# Find commits unique to the backport branch
echo "Finding commits unique to the backport branch..."
ALL_COMMITS=$(git log --no-merges $BACKPORT_BRANCH --pretty=format:"%H" --reverse \
    --not $(git for-each-ref --format="%(refname)" refs/heads | grep -Fv refs/heads/$BACKPORT_BRANCH))

if [ -z "$ALL_COMMITS" ]; then
  echo "No commits found to backport from $BACKPORT_BRANCH to $CURRENT_BRANCH."
  
  # Restore stashed changes if any
  if [ "$CHANGES_STASHED" = true ]; then
    echo "Restoring your stashed changes..."
    git stash pop
    echo "Notice: Your previously uncommitted changes have been restored. Please review these changes."
  fi
  
  exit 0
fi

# Check for progress file and load already processed commits
COMPLETED_COMMITS=""
if [ -f "$PROGRESS_FILE" ]; then
  echo "Found previous backport progress."
  COMPLETED_COMMITS=$(cat "$PROGRESS_FILE")
  echo "Already processed $(echo "$COMPLETED_COMMITS" | wc -w) commits."
fi

# Filter out already processed commits
COMMITS_TO_PROCESS=""
for COMMIT in $ALL_COMMITS; do
  if [[ ! $COMPLETED_COMMITS == *"$COMMIT"* ]]; then
    COMMITS_TO_PROCESS="$COMMITS_TO_PROCESS $COMMIT"
  fi
done
COMMITS_TO_PROCESS=$(echo "$COMMITS_TO_PROCESS" | xargs)  # Trim whitespace

if [ -z "$COMMITS_TO_PROCESS" ]; then
  echo "All commits have already been processed!"
  
  # Restore stashed changes if any
  if [ "$CHANGES_STASHED" = true ]; then
    echo "Restoring your stashed changes..."
    git stash pop
    echo "Notice: Your previously uncommitted changes have been restored. Please review these changes."
  fi
  
  # Clean up progress file
  rm -f "$PROGRESS_FILE"
  
  exit 0
fi

# Display a list of commits that will be cherry-picked
echo "The following commits will be backported:"
echo "------------------------------------------------"
count=1
for COMMIT in $COMMITS_TO_PROCESS; do
  COMMIT_SHORT=$(git rev-parse --short $COMMIT)
  COMMIT_DATE=$(git show -s --format=%ci $COMMIT)
  COMMIT_AUTHOR=$(git show -s --format=%an $COMMIT)
  COMMIT_SUBJECT=$(git show -s --format=%s $COMMIT)
  echo "$count. $COMMIT_SHORT - $COMMIT_DATE - $COMMIT_AUTHOR"
  echo "   $COMMIT_SUBJECT"
  echo ""
  count=$((count+1))
done
echo "------------------------------------------------"

# Ask for confirmation
read -p "Do you want to proceed with the backport? (y/n): " confirm
if [[ $confirm != [yY] && $confirm != [yY][eE][sS] ]]; then
  echo "Backport operation cancelled."
  
  # Restore stashed changes if any
  if [ "$CHANGES_STASHED" = true ]; then
    echo "Restoring your stashed changes..."
    git stash pop
    echo "Your previously uncommitted changes have been restored."
  fi
  
  exit 0
fi

# Extract the JIRA issue from the source branch
if [[ $BACKPORT_BRANCH =~ ^([^/]+)/(.*) ]]; then
  JIRA_ISSUE="${BASH_REMATCH[1]}"
  DESCRIPTION="${BASH_REMATCH[2]}"
else
  # If backport branch doesn't match the pattern, use it as-is
  JIRA_ISSUE=$BACKPORT_BRANCH
  DESCRIPTION=""
fi

# Replace any slash in the target branch part with dash for branch name safety
# Make the entire TARGET_BRANCH one unit by replacing all slashes with dashes
TARGET_SAFE=$(echo "$CURRENT_BRANCH" | tr '/' '-')
NEW_BRANCH_NAME="${JIRA_ISSUE}/bp/${TARGET_SAFE}"
if [[ -n "$DESCRIPTION" ]]; then
  NEW_BRANCH_NAME="${NEW_BRANCH_NAME}/${DESCRIPTION}"
fi

# Ask for confirmation or modification of branch name
echo "Will create new branch: $NEW_BRANCH_NAME"
read -p "Enter a different branch name or press Enter to accept: " branch_input
if [ ! -z "$branch_input" ]; then
  NEW_BRANCH_NAME="$branch_input"
fi

# Create and checkout the new branch
echo "Creating and switching to new branch: $NEW_BRANCH_NAME"
git checkout -b "$NEW_BRANCH_NAME"
if [ $? -ne 0 ]; then
  echo "Failed to create or switch to branch: $NEW_BRANCH_NAME"
  
  # Restore stashed changes if any
  if [ "$CHANGES_STASHED" = true ]; then
    echo "Restoring your stashed changes..."
    git stash pop
  fi
  
  exit 1
fi

# Cherry-pick each commit with modified messages
echo "Starting cherry-pick process..."
CURRENT_COMPLETED="$COMPLETED_COMMITS"

for COMMIT in $COMMITS_TO_PROCESS; do
  # Get the original commit message
  COMMIT_MSG=$(git log --format=%B -n 1 $COMMIT)
  COMMIT_SHORT=$(git rev-parse --short $COMMIT)
  
  echo "Processing commit: $COMMIT_SHORT"
  
  # Cherry-pick the commit
  if ! git cherry-pick $COMMIT; then
    echo "Conflict detected while cherry-picking $COMMIT_SHORT."
    echo "Please resolve conflicts and run 'git cherry-pick --continue'."
    echo "After that, run this script again to continue the backport process."
    
    # Save progress
    echo "$CURRENT_COMPLETED" > "$PROGRESS_FILE"
    echo "Progress saved. $(echo "$CURRENT_COMPLETED" | wc -w) commits processed so far."
    
    exit 1
  fi
  
  # Amend the commit message to indicate it's a backport
  git commit --amend --no-verify -m "[ORIGINAL]" -m "$COMMIT_MSG" -m "[END ORIGINAL]" -m "Backported from $BACKPORT_BRANCH (v$BACKPORT_VERSION) to $NEW_BRANCH_NAME (v$CURRENT_VERSION)" -m "Original commit: $COMMIT" --no-edit
  
  echo "Successfully backported commit: $COMMIT_SHORT"
  
  # Add to completed list
  CURRENT_COMPLETED="$CURRENT_COMPLETED $COMMIT"
  
  # Update progress file after each successful commit
  echo "$CURRENT_COMPLETED" > "$PROGRESS_FILE"
done

echo "Success! All commits from $BACKPORT_BRANCH (v$BACKPORT_VERSION) have been cherry-picked to branch $NEW_BRANCH_NAME (based on $CURRENT_BRANCH v$CURRENT_VERSION)."
echo "The changes are local only and have not been pushed."
echo "Review the changes and then push to remote with: git push origin $NEW_BRANCH_NAME"

# Restore stashed changes if any
if [ "$CHANGES_STASHED" = true ]; then
  echo "Restoring your stashed changes..."
  git stash pop
  echo "Important: Your previously uncommitted changes have been restored. Please review and commit these changes as needed."
fi

# Clean up progress file on successful completion
rm -f "$PROGRESS_FILE"
