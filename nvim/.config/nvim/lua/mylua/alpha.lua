--require'alpha'.setup(require'alpha.themes.dashboard'.opts)


math.randomseed( os.time() ) -- For random header.

-- To split our quote, artist and source.
-- And automatically center it for screen loader of the header.
local function split(s)
  local t = {}
  local max_line_length = vim.api.nvim_get_option('columns')
  local longest = 0 -- Value of longest string is 0 by default
  for far in s:gmatch("[^\r\n]+") do
    -- Break the line if it's actually bigger than terminal columns
    local line
    far:gsub('(%s*)(%S+)',
    function(spc, word)
      if not line or #line + #spc + #word > max_line_length then
        table.insert(t, line)
        line = word
      else
        line = line..spc..word
        longest = max_line_length
      end
    end)
    -- Get the string that is the longest
    if (#line > longest) then
      longest = #line
    end
    table.insert(t, line)
  end
  -- Center all strings by the longest
  for i = 1, #t do
    local space = longest - #t[i]
    local left = math.floor(space/2)
    local right = space - left
    t[i] = string.rep(' ', left) .. t[i] .. string.rep(' ', right)
  end
  return t
end

-- Function to retrieve console output.
local function capture(cmd)
  local handle = assert(io.popen(cmd, 'r'))
  local output = assert(handle:read('*a'))
  handle:close()
  return output
end

-- Create button for initial keybind.
--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Keyword",
  }
  if keybind then
    keybind_opts = vim.F.if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
    opts.keymap = {"n", sc_, keybind, keybind_opts}
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, "normal", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

-- All custom headers
Headers = {

  {
    [[                                                                     ]],
    [[       ███████████           █████      ██                     ]],
    [[      ███████████             █████                             ]],
    [[      ████████████████ ███████████ ███   ███████     ]],
    [[     ████████████████ ████████████ █████ ██████████████   ]],
    [[    █████████████████████████████ █████ █████ ████ █████   ]],
    [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
    [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
    [[ ██████   ██  ███████████████   ██ █████████████████ ]],
    [[ ██████   ██  ███████████████   ██ █████████████████ ]],
  },

  {
    [[=================     ===============     ===============   ========  ========]],
    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
    [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
    [[||.=='    _-'                                                     `' |  /==.||]],
    [[=='    _-'                        N E O V I M                         \/   `==]],
    [[\   _-'                                                                `-_   /]],
    [[ `''                                                                      ``' ]],
  },

  {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  },

  {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  },

  {
    [[              __                                                     ]],
    [[             /\ \__                                                  ]],
    [[  ___     ___\ \  _\         __    ___ ___      __      ___    ____  ]],
    [[/  _ `\  / __`\ \ \/       / __`\/  __` __`\  / __`\   / ___\ / ,__\ ]],
    [[/\ \/\ \/\ \_\ \ \ \_     /\  __//\ \/\ \/\ \/\ \_\.\_/\ \__//\__, `\]],
    [[\ \_\ \_\ \____/\ \__\    \ \____\ \_\ \_\ \_\ \__/.\_\ \____\/\____/]],
    [[ \/_/\/_/\/___/  \/__/     \/____/\/_/\/_/\/_/\/__/\/_/\/____/\/___/ ]],
  },

  --{
  --  "            :h-                                  Nhy`               ",
  --  "           -mh.                           h.    `Ndho               ",
  --  "           hmh+                          oNm.   oNdhh               ",
  --  "          `Nmhd`                        /NNmd  /NNhhd               ",
  --  "          -NNhhy                      `hMNmmm`+NNdhhh               ",
  --  "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
  --  "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
  --  "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
  --  "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
  --  " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
  --  " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
  --  " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
  --  " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
  --  "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
  --  "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
  --  "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
  --  "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
  --  "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
  --  "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
  --  "       //+++//++++++////+++///::--                 .::::-------::   ",
  --  "       :/++++///////////++++//////.                -:/:----::../-   ",
  --  "       -/++++//++///+//////////////               .::::---:::-.+`   ",
  --  "       `////////////////////////////:.            --::-----...-/    ",
  --  "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
  --  "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
  --  "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
  --  "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
  --  "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
  --  "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
  --  "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
  --  "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
  --  "                        .-:mNdhh:.......--::::-`                    ",
  --  "                           yNh/..------..`                          ",
  --  "                                                                    ",
  --}

}

--
-- Sections for Alpha.
--

local padding_between = 2
local function getHeader()
  local pos = math.random(#Headers)
  -- Reduce padding_between for doom
  if pos == 2 then
    padding_between = 1
  end
  return Headers[pos]
end

local default_header = {
  type = "text",
  --val = Headers[math.random(#Headers)],
  val = getHeader(),
  opts = {
    position = "center",
    hl = "Type"
    -- wrap = "overflow";
  }
}

local function footerGen()
  --local total_plugins = #vim.tbl_keys(packer_plugins)
  local total_plugins = vim.api.nvim_eval("len(keys(g:plugs))")
  local datetime = os.date("%d-%m-%Y  %H:%M:%S")
  return total_plugins .. " plugins  " .. datetime
end

local footer = {
  type = "text",
  -- Change 'rdn' to any program that gives you a random quote.
  -- https://github.com/BeyondMagic/scripts/blob/master/quotes/rdn
  -- Which returns one to three lines, being each divided by a line break.
  -- Or just an array: { "I see you:", "Above you." }
  --val = split(capture('rdn')),
  --val = footerGen(),
  val='',
  opts = {
    position = "center",
    hl = "Number",
  }
}

local buttons = {
  type = "group",
  val = {
    --button("e", "  New Buffer",            ':tabnew<CR>'),
    --button(".", "ﱮ  File Explorer",         'lua require(\'telescope.builtin\').file_browser({hidden=1,})<cr>'),
    --button("f", "  Find File",             ':Telescope find_files<CR>'),
    --button("r", "  Recently opened files", ':Telescope oldfiles<CR>'),
    ----button("g", "  Open Last Session",     ':source ~/.config/nvim/session.vim<CR>'),
    ----button("g", "  Word Finder",           ':Telescope live_grep<CR>'),
    --button("h", "  Help",                  ':Telescope help_tags<CR>'),
    --button("m", "  Man Pages",             ':Telescope man_pages<CR>'),
    --button("u", "  Update",                ':PlugUpgrade | PlugUpdate<cr>'),
    ----button("l", "  Marks",                 ':Telescope marks<CR>'),
    --button("q", "  Quit",                  ':qa<CR>'),

    -- NO NEW KEYBINDINGS --
    button("e", "  New Buffer",            ':enew<cr>'),
    button("SPC .", "ﱮ  File Explorer"),
    --button("SPC f f", "  Find File"),
    button("SPC f r", "  Recent Files"),
    --button("SPC g", "  Open Last Session"),
    --button("SPC g", "  Word Finder"),
    button("SPC f h", "  Help"),
    button("SPC f m", "  Man Pages"),
    button("SPC o a", "  Open Org Agenda"),
    button("SPC v r c", "  Settings"),
    button("u", "  Update",                ':PlugUpgrade | PlugUpdate<cr>'),
    --button("SPC l", "  Marks"),
    button("q", "  Quit",                  ':qa<CR>'),
  },
  opts = {
    spacing = 1
  }
}

local section = {
  header = default_header,
  buttons = buttons,
  footer = footer,
}

--
-- Centering handler of ALPHA
--

local ol = { -- occupied lines
  icon = #default_header.val,            -- CONST: number of lines that your header will occupy
  message = 1 + #footer.val,             -- CONST: because of padding at the bottom
  length_buttons = #buttons.val * 2 - 1, -- CONST: it calculate the number that buttons will occupy
  neovim_lines = 2,                      -- CONST: 2 of command line, 1 of the top bar
  --padding_between = 2,                   -- STATIC: can be set to anything, padding between keybinds and header
  padding_between = padding_between,     -- STATIC: can be set to anything, padding between keybinds and header
}

local left_terminal_value = vim.api.nvim_get_option('lines') - (ol.length_buttons + ol.message + ol.padding_between + ol.icon + ol.neovim_lines)
local top_padding = math.floor(left_terminal_value / 2)
local bottom_padding = left_terminal_value - top_padding

--
-- Set alpha sections
--

local opts = {
  layout = {
    { type = "padding", val = top_padding },
    section.header,
    { type = "padding", val = ol.padding_between },
    section.buttons,
    section.footer,
    { type = "padding", val = bottom_padding },
  },
  opts = {
    margin = 5
  },
}

--local dashboard = require'alpha.themes.dashboard'
--dashboard.section.footer.val =
require'alpha'.setup(opts)

return {
  button = button,
  section = section,
  opts = opts,
}

