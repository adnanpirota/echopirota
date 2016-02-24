require "date"
require "net/http"
require "uri"

class ListeningWorker
  include Sidekiq::Worker
  def perform(radio_uri)
    puts "Radio URI is: #{radio_uri}"
    radio_url = uri_to_url(radio_uri)
    puts "URL is: #{radio_url}"

    # we create the file name
    file_name_to_be_created = compose_file_name(radio_url)

    # repeat recording 20 times
    #20.times do |times|
      record(file_name_to_be_created, radio_url)
    #  puts "Times osht: #{times}"
    #end
  end

  def uri_to_url(incomming_uri)
    url = URI.parse(incomming_uri)
  end

  def compose_file_name(url)
    file_name = 'public/' + url.host + DateTime.now.to_s + '.mp3'
  end

  def record(file_name, url)
    puts "I'm in record with file_name and url: #{file_name} ===== #{url}"
    start_time = DateTime.now

    f = open(file_name, "w", encoding: 'ASCII-8BIT')
    Net::HTTP.start(url.host, url.port) do |http|
      http.request_get('/magic1054.mp3') do |resp|
        resp.read_body do |segment|
          f.write(segment)
          present_time = DateTime.now
          if ((present_time - start_time) * 24 * 60 * 60).to_i > 20
            puts "pe boj close fallin"
            f.close()
            break
          else
          end # end of if else loop
        end # fundi i read_body
      end # end of http.request_get
    end # end of Net::HTTP
  end # end of record method



end
