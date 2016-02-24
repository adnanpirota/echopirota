class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  p "para se me thir perform _async te icy-e"
  ListeningWorker.perform_in(10.seconds, 'http://icy-e-bz-04-cr.sharp-stream.com:8000/magic1054.mp3')
  #p "para se me thir perform _async te media-sov"
  #ListeningWorker.perform_in(10.seconds, 'http://media-sov.musicradio.com:80/CapitalMP3')
end
