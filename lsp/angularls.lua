-- Only start angularls in Angular projects
return {
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern('angular.json')(fname)
  end,
}
