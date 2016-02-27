require "date"
require "net/http"
require "uri"

class ListeningWorker
  include Sidekiq::Worker
  def perform(radio_uri)
    #puts "Radio URI is: #{radio_uri}"
    radio_url = uri_to_url(radio_uri)
    puts "URL is: #{radio_url}"

    # we create the file name

    stream_path = get_stream_path(radio_uri)
    puts "stream_path osht: #{stream_path}"
    # repeat recording 20 times
    20.times do |x|
      puts x
      file_name = compose_file_name(radio_url)
      record(file_name, radio_url, stream_path)
      MatchingWorker.perform_async(file_name)
    end
  end

  def uri_to_url(incomming_uri)
    url = URI.parse(incomming_uri)
  end

  def compose_file_name(url)
    #file_name = 'public/' + url.host + DateTime.now.to_s + '.mp3'
    file_name = 'public/' + url.host + Time.now.to_i.to_s + '.mp3'
  end

  def get_stream_path(radio_uri)
    stream_path = ''
    arr = URI::split(radio_uri)
    arr.reverse!
    arr.each do |arr_item|
      #puts "arr_item osht: #{arr_item.inspect}"
      if arr_item.nil?

      else
        stream_path = arr_item
        #puts "ne get_stream_path stream_path osth: #{stream_path}"
        break
      end
    end
    stream_path
  end

  def record(file_name, url, stream_path)

    puts "Records: #{file_name} === #{url} === #{stream_path}"
    start_time = DateTime.now

    f = open(file_name, "w", encoding: 'ASCII-8BIT')
    Net::HTTP.start(url.host, url.port) do |http|
      http.request_get(stream_path) do |resp|
        resp.read_body do |segment|
          f.write(segment)
          present_time = DateTime.now
          if ((present_time - start_time) * 24 * 60 * 60).to_i > 20
            puts "pe boj close fallin #{f.inspect}"
            f.close()
            return
          else
          end # end of if else loop
        end # fundi i read_body
      end # end of http.request_get
    end # end of Net::HTTP
  end # end of record method

  #def self.twenty_times(radio_uri)
  #  puts "jom ne twenty times #{radio_uri}"
  #  20.times do |x|
  #    puts x
  #    perform_async(radio_uri)
  #  end
  #end
end
