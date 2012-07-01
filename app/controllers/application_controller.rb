class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with name: "kvn", password: "een super lastig wachtwoord"
end
