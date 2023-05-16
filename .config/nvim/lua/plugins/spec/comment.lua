local M = {}

function M.setup()
	require("mini.comment").setup({
        options = {
            ignore_blank_line = false,
            start_of_line = false,
            pad_comment_parts = true,
        },
        mappings = {
            comment = 'gc',
            comment_line = 'gcc',
            textobject = 'gc',
        },
        hooks = {
            pre = function() end,
            post = function() end,
        },
    })
end

return M
