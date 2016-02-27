require 'json'

class MatchingWorker
  include Sidekiq::Worker

  def perform(file_name)
    puts "tung prej perform ne matching worker"
    puts file_name
    log_file = generate_log_name(file_name)
    #cmd = "echoprint-codegen #{file_name} > #{log_file}"

    # ekzekutojme komanden ne shell per me e mar kodin
    cmd = `echoprint-codegen #{file_name}`

    # e kthej outputin ne json
    data = JSON.parse(cmd)
    puts "data e echoprint-codegenit te konges ..."
    puts data.inspect

    # e nxjerrim fingerprintin
    fp_code = data[0]['code']
    p "fp_code i konges osht: "
    p fp_code

    exists = does_fingerprint_exist(fp_code)
    if exists == true
      puts "fingerprint exists"
    else
      puts "fingerprint does not exist"
      insert_fingerprint(fp_code)
    end

  end

  # metoda qe e kqyr a ekziston fingerptinti ne echoprint
  def does_fingerprint_exist(fp_code)
    #match = false
    puts "para se me kqyr a po ekziston"

    #http = Curl.get("http://80.80.172.245:8080/query", {fp_code: fp_code, length: 40 , codever: 4.12})
    http = Curl.get("http://80.80.172.245:8080/query", {fp_code: fp_code})

    puts "mbas http = curl.get blla blla blla"
    body_str = http.body_str


    data = JSON.parse(body_str)
    puts "data qe osht json.parse(body_str osht: #{data})"
    # we extract the match element
    fp_match = data['match']
    puts "fp_match osht: #{fp_match}"


    # we respond with true or false
    if fp_match == true
      match = true
    else
      mathch = false
    end
    match
  end

  def generate_log_name(file_name)
    file_name_without_mp3 = file_name.chomp('.mp3')
    returning_file_name = file_name_without_mp3 + '.txt'
  end

  def insert_fingerprint(fp_code)
    puts "jom ne insert_fingerprint ..."
    http = Curl.post("http://80.80.172.245:8080/ingest", {fp_code: fp_code, length: 40 , codever: 4.12})
    body =  http.body_str
    data = JSON.parse(body)
    puts "data respektivisht pergjigja nga curl.post osht: #{data}"
  end
end
