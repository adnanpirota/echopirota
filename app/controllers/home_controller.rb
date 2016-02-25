#require "http"
#require "net/http"
#require "uri"
#require "echonest-ruby-api"
require 'echonest'
require 'json'

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

    ###
    #song = Echonest::Song.new('UIGYBYREFYB127RYP')
    #puts song.inspect
    #genre = Echonest::Genre.new('UIGYBYREFYB127RYP', 'folk rock')
    #puts genre.inspect
    #puts genre.artists

    fajlli = Rails.root.join("public", "icy-e-bz-04-cr.sharp-stream.com2016-02-25T10:27:13+01:00.mp3")
    #puts fajlli.inspect
    #code = song.echoprint_code(fajlli)
    #puts code.inspect
    #cd = code.split
    #pergjigja = song.identify(code)
    #pergjigja.inspect

    echonest = Echonest('UIGYBYREFYB127RYP')
    @analysis = echonest.track.analysis(fajlli)

    metadata = @analysis.beats
    metadata2 = @analysis.segments
    metadata3 = @analysis.artist
    metadata4 = @analysis.album
    metadata5 = @analysis.title
    #metadata6 = @analysis.track.num_samples
    puts metadata3
    puts metadata4
    puts metadata5
    #puts metadata6
    #@json = JSON.parse(@analysis.to_s)


  end
end
