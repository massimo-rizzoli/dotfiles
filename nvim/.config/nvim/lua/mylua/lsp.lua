--require('lspconfig')[%YOUR_LSP_SERVER%].setup {
--    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--  }
-- For configuring nvim-cmp for each language
local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }, _config or {})
end



require'lspconfig'.hls.setup{config()}



-- Pyright with completion-nvim
--require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.pyright.setup{config()}



-- Lua language server
--require'lspconfig'.sumneko_lua.setup{}
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = ''
local sumneko_binary = 'lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  config();
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}



require'lspconfig'.vimls.setup{config()}



require'lspconfig'.texlab.setup{
  config();
  build = {
    onSave = true
  }
}



require'lspconfig'.bashls.setup{config()}



require'lspconfig'.esbonio.setup{config()}
