# Base controller for all Web endpoints
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
