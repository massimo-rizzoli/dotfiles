require("org-bullets").setup{
  symbols ={
    headlines={ "", "", "◉", "○" },
    -- or a function that receives the defaults and returns a list
    --headlines = function(default_list)
    --  table.insert(default_list, "♥")
    --  return default_list
    --end,
    checkboxes = {
      cancelled = { "", "OrgCancelled" },
      done = { "✓", "OrgDone" },
      todo = { "˟", "OrgTODO" },
    },
  }
}
