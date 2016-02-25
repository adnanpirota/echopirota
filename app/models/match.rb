class Match < ApplicationRecord
  belongs_to :fingerprint
  belongs_to :url
end
