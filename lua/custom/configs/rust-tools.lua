local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local mason_registry = require("mason-registry")

local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
-- 这里可能因为操作系统不同/插件版本不同后缀会改变, 如果debug出现问题是把后缀换成.so试试
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.dylib"

local opts = {
  server = {
    checkOnSave = {
    on_attach = on_attach,
    capabilities = capabilities,
      allFeatures = true,
    },
  },
  dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
}

return opts
