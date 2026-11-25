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
          -- dev uwiki: its venv has the source editable and its dependencies; the installed
          -- release with PYTHONPATH on the source breaks once the source needs a new dependency
          cmd = { vim.fn.expand("~/prj/hiqsol/uwiki/.venv/bin/uwiki"), "lsp" },
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
