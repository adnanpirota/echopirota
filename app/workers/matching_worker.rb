require 'json'

class MatchingWorker
  include Sidekiq::Worker

  def perform(file_name, radio_id)

    # We execute the shell command to get the echoprint codegen
    cmd = `echoprint-codegen #{file_name}`

    data = JSON.parse(cmd)

    # we extract the fingerprint
    fp_code = data[0]['code']

    track_id = does_fingerprint_exist(fp_code)

    if track_id.length > 0
      # if fingerprint exists we add it to matches table
      add_to_matches(track_id, radio_id)
    else
      # else we insert fingerprint in echoprint and local database
      insert_fingerprint(fp_code)
    end

  end

  # does_fingerprint_exist method checks weather fingerprint exist in echonest database and if it exists it returns fingerprints track_id
  def does_fingerprint_exist(fp_code)
    track_id = ''

    # we check if fingerprint exists in echoprint
    http = Curl.get("http://localhost:8080/query", {fp_code: fp_code})

    body_str = http.body_str
    data = JSON.parse(body_str)

    # we extract the match element
    fp_match = data['match']


    # if match is true we respond with track_id otherwase send empty response
    if fp_match == true
      # if fingerprint is matched we return track_id that we can use to identify the fingerprint in local database to insert the match
      track_id = data['track_id']
    else
      track_id = ''
    end
    #match
  end

  # insert_fingerprint method inserts fingerprint to echonest as well as local database
  def insert_fingerprint(fp_code)
    # we insert the fingerprint in the echprint database
    http = Curl.post("http://localhost:8080/ingest", {fp_code: fp_code, length: 40 , codever: 4.12})
    body =  http.body_str
    data = JSON.parse(body)

    # we retrieve the returned track_id and title so that we can insert it in our local database
    track_id = data['track_id']
    track_title = data['title']
    # we insert the fingerprint in local database
    fp_lokal = Fingerprint.create(track_id: track_id, title: track_title, fingerprint: fp_code)
  end

  # add_to_matches method adds the matched fingerprint to matches table
  def add_to_matches(track_id, radio_id)
    fp_matched = Fingerprint.find_by track_id: track_id
    Match.create(fingerprint_id: fp_matched.id, radio_id: radio_id)
  end
end
