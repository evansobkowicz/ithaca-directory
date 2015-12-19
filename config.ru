require File.expand_path('../directory.rb', __FILE__)
use Rack::ShowExceptions
run IthacaDirectoryApp.new
