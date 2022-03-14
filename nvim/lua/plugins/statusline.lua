require("linha").add_module("Test", {
  provider = function()
    return "test%p"
  end,
  highlight = {
    fg = "#e0e0e0",
  },
  before = {
    content = " ",
  },
  after = {
    content = " ",
  },
})

require("linha").setup {
  builder = {
    active = "Mode|FileName|=|FileType|Diagnostics|LinePercent",
    inactive = "FileName|=|FileType",
  },
}
