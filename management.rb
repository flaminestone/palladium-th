require 'sinatra'
require 'sequel'
require 'sqlite3'
require 'json'
require_relative 'database/database'

# models
require_relative 'database/models/User'
require_relative 'database/models/Product'
require_relative 'database/models/Plan'
require_relative 'database/models/Run'
require_relative 'database/models/ResultSet'

# core modules
require_relative 'core/auth'

# utilits
require_relative 'utilits/encrypt'
