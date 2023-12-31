local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local mason_registry = require("mason-registry")

local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"

local liblldb_path = codelldb_root .. "lldb/lib/liblldb"
if (vim.loop.os_uname().sysname == "Linux")
then
  liblldb_path = liblldb_path .. ".so"
else
  liblldb_path = liblldb_path .. ".dylib"
end

local opts = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
}

return opts
