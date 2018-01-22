require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

<<<<<<< HEAD
use Rack::MethodOverride
use UserController
use TerritoryController
=======
>>>>>>> 74d0270064f178e45cef7724567406b4147d9126
run ApplicationController
