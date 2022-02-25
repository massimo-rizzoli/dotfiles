local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },

      { name = 'path' },
      { name = '/host' },
      { name = 'orgmode' },
    }
  })

--
--require'cmp'.setup {
--  enabled = true;
--  autocomplete = true;
--  debug = false;
--  min_length = 1;
--  preselect = 'enable';
--  throttle_time = 80;
--  source_timeout = 200;
--  incomplete_delay = 400;
--  max_abbr_width = 100;
--  max_kind_width = 100;
--  max_menu_width = 100;
--  documentation = false;
--
--  source = {
--    path = true;
--    buffer = true;
--    calc = true;
--    vsnip = true;
--    nvim_lsp = true;
--    nvim_lua = true;
--    spell = true;
--    tags = true;
--    snippets_nvim = true;
--    treesitter = true;
--    orgmode = true;
--  };
--
--  -- Autoclose
--  map_cr = true, --  map <CR> on insert mode
--  map_complete = true, -- it will auto insert `(` after select function or method item
--  auto_select = false,  -- auto select first item
--}
--local t = function(str)
--  return vim.api.nvim_replace_termcodes(str, true, true, true)
--end
--
--local check_back_space = function()
--    local col = vim.fn.col('.') - 1
--    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--        return true
--    else
--        return false
--    end
--end
--
---- Use (s-)tab to:
----- move to prev/next item in completion menuone
----- jump to prev/next snippet's placeholder
--_G.tab_complete = function()
--  if vim.fn.pumvisible() ~= 0 then
--    return t "<C-n>"
--  -- elseif vim.fn.call("vsnip#available", {1}) == 1 then
--  --   return t "<Plug>(vsnip-expand-or-jump)"
--  elseif check_back_space() then
--    return t "<Tab>"
--  else
--    --return vim.fn['cmp#complete']()
--    return vim.fn['cmp.complete']()
--  end
--end
--_G.s_tab_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    return t "<C-p>"
--  -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--  --   return t "<Plug>(vsnip-jump-prev)"
--  else
--    -- If <S-Tab> is not working in your terminal, change it to <C-h>
--    -- return t "<S-Tab>"
--    return t "<C-h>"
--  end
--end
--
--vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})