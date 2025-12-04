local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add {
    source = "vladdoster/remember.nvim",
  }

  require "remember"
end)
