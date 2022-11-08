local config = {
  cmd = { '/nix/store/djgqb848fpvpv899g9m0kjmipldscqbp-user-environment/bin/jdt-language-server' },
  root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
