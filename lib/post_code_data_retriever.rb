require 'post_code_data_retriever/version'
require 'retrieval_result'
require 'post_code_validator'
require 'json'
require 'httparty'

module PostCodeDataRetriever
  def self.get_coordinates(post_code)

    post_code.gsub!(/\s+/, '')
    post_code.upcase!

    # puts "retrieving coordinates of #{post_code}"

    unless PostCodeValidator.valid_post_code(post_code)
      return RetrievalResult.new(-1, 'Input provided is not a valid UK post code.')
    end

    response = nil
    begin
      # puts "http://uk-postcodes.com/postcode/#{post_code}.json"
      response = HTTParty.get("http://uk-postcodes.com/postcode/#{post_code}.json")
    rescue StandardError => se
      # puts se.backtrace[0..10].join("\n")
      return RetrievalResult.new(
        -2, "Connection error while retrieving post codes from uk-postcodes.com (#{se.message})")
    end

    # puts response
    case response.code
    when 200
      return map_uk_postcodes_response_to_result(response.body)
    when 404
      return RetrievalResult.new(
        -4, "Post code provided(#{post_code}) does not map to existing data.")
    end

    RetrievalResult.new
  end

  ##
  # Maps response of uk-postcodes.com to result returned from this module
  #
  def self.map_uk_postcodes_response_to_result(input)
    geoloc_json_data = JSON.parse(input)
    # puts geoloc_json_data
    latitude = geoloc_json_data['geo']['lat']
    longitude = geoloc_json_data['geo']['lng']
    easting = geoloc_json_data['geo']['easting']
    northing = geoloc_json_data['geo']['northing']
    constituency_title = geoloc_json_data['administrative']['constituency']['title']
    if geoloc_json_data['administrative']['district']
      district_title = geoloc_json_data['administrative']['district']['title']
    elsif geoloc_json_data['administrative']['council']
      district_title = geoloc_json_data['administrative']['council']['title']
    else
      district_title = ''
    end

    ward_title = geoloc_json_data['administrative']['ward']['title']

    RetrievalResult.new(0, '', latitude, longitude, easting, northing,
                        constituency_title, district_title, ward_title)
  end
end
