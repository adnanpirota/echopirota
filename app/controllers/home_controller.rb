require "http"
require "net/http"
require "uri"

class HomeController < ApplicationController
  def index
    #url = URI.parse('http://icy-e-bz-04-cr.sharp-stream.com:8000/magic1054.mp3')
    #puts url.inspect
    #Net::HTTP.start(url.host, url.port) do |http|
      #f = open("saved_stream.mp3", "w")
      #begin
        #http.request_get('/home/cyber/adnanpirota/saved_stream.mp3') do |resp|
         # resp.read_body do |segment|
          #  f.write(segment)
          #end
        #end
      #ensure
        #f.close()
      #end
      #puts http.inspect
    #end

	  #ListeningWorker.perform_async('http://icy-e-bz-04-cr.sharp-stream.com:8000/magic1054.mp3')
    #ListeningWorker.perform_async('http://media-sov.musicradio.com:80/CapitalMP3')
  end
end
