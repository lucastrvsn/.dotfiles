require('rooter').setup({
  echo = false,
  patterns = {
    '.git',
    'package.json'
  },
  non_project_files = 'current',
})
