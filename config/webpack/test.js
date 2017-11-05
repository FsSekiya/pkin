const environment = require('./environment')
const merge = require('webpack-merge')

const configs = {
  
}

module.exports = merge(environment.toWebpackConfig(), configs)
