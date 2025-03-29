require "core.set"
require "core.remap"
require "core.autocmd"
require "core.lazy"

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end
