require "date"
require "net/http"
require "uri"

class ListeningWorker
  include Sidekiq::Worker
  def perform(radio_id)
    #puts "Radio URI is: #{radio_uri}"
    radio_uri = Radio.find(radio_id).uri
    radio_url = uri_to_url(radio_uri)

    # we create the stream name
    stream_path = get_stream_path(radio_uri)

    # repeat recording 20 times
    20.times do |x|
      file_name = compose_file_name(radio_url)
      record(file_name, radio_url, stream_path)
      # After each recording we process the file using MatchingWorker sidekiq worker
      MatchingWorker.perform_async(file_name, radio_id)
    end
  end

  def uri_to_url(incomming_uri)
    url = URI.parse(incomming_uri)
  end

  def compose_file_name(url)
    file_name = 'public/' + url.host + Time.now.to_i.to_s + '.mp3'
  end

  def get_stream_path(radio_uri)
    stream_path = ''
    arr = URI::split(radio_uri)
    arr.reverse!
    arr.each do |arr_item|
      if arr_item.nil?
      else
        stream_path = arr_item
        break
      end
    end
    stream_path
  end

  def record(file_name, url, stream_path)

    start_time = DateTime.now

    f = open(file_name, "w", encoding: 'ASCII-8BIT')
    Net::HTTP.start(url.host, url.port) do |http|
      http.request_get(stream_path) do |resp|
        resp.read_body do |segment|
          f.write(segment)
          present_time = DateTime.now
          # If time is greater than 20 sec we close the file and return
          if ((present_time - start_time) * 24 * 60 * 60).to_i > 20
            f.close()
            return
          else
          end # end of if else loop
        end # fundi i read_body
      end # end of http.request_get
    end # end of Net::HTTP
  end # end of record method
end
