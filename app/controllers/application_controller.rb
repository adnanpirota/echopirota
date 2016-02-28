class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #p "para se me thir perform _async te icy-e"
  ListeningWorker.perform_at(10.seconds, 1)
  #p "para se me thir perform _async te media-sov"
  ListeningWorker.perform_at(20.seconds, 2)
end
