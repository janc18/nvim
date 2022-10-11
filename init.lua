require('impatient')

local builtin_loads = {
  '2html_plugin',
  'cfilter',
  'gzip',
  'man',
  'matchit',
  'matchparen',
  'msgpack_autoload',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'node_provider',
  'perl_provider',
  'pythonx_provider',
  'python3_provider',
  'remote_plugins',
  'ruby_provider',
  'shada_autoload',
  'shada_plugin',
  'spellfile_plugin',
  'sql_completion',
  'syntax_completion',
  'tar',
  'tarPlugin',
  'tutor_mode_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin'
}

for _, load in pairs(builtin_loads) do
  vim.g['loaded_' .. load] = 1
end

require('wuelner')

