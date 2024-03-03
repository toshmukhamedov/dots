require "core"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
---@diagnostic disable-next-line
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").lazy(lazypath)
end

---@diagnostic disable-next-line
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", require "plugins.configs.lazy_nvim")
