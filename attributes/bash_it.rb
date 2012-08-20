node.default['bash_it'] ={
  'enabled_plugins' => {
    'aliases'    => %w[general],
    'completion' => %w[defaults git],
    'plugins'    => %w[ssh]
  },
  'custom_plugins' => [
    # template files added here will be installed under <bash-it dir>/custom/
  ]
}
