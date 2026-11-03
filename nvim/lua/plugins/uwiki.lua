-- uwiki language server in wikis with uwiki.toml, marksman in every other markdown project
local function uwiki_root(bufnr)
  return vim.fs.root(bufnr, { "uwiki.toml" })
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        uwiki = {
          mason = false,
          cmd = { "uwiki", "lsp" },
          -- dev uwiki source instead of the installed release
          cmd_env = { PYTHONPATH = vim.fn.expand("~/prj/hiqsol/uwiki/src") },
          filetypes = { "markdown" },
          -- only inside a wiki: without a root nvim would start it in any folder
          root_dir = function(bufnr, on_dir)
            local root = uwiki_root(bufnr)
            if root then
              on_dir(root)
            end
          end,
        },
        marksman = {
          root_dir = function(bufnr, on_dir)
            if not uwiki_root(bufnr) then
              on_dir(vim.fs.root(bufnr, { ".marksman.toml", ".git" }))
            end
          end,
        },
      },
    },
  },
}
