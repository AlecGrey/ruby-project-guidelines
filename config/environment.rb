require 'bundler/setup'
require 'rest-client'
require 'json'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')

# ActiveRecord::Base.logger.level = 1

require_rel '../lib'
require_all 'app'
require_rel '../bin/menu.rb'
