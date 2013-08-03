require 'post_code_data_retriever/version'
require 'retrieval_result'
require 'post_code_validator'
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
      puts "http://uk-postcodes.com/postcode/#{post_code}.json"
      response = HTTParty.get("http://uk-postcodes.com/postcode/#{post_code}.json")
    rescue StandardError => se
      puts se.message
      puts se.backtrace[0..10].join("\n")
      puts 'error'
      return RetrievalResult.new(-2, 'Connection error while retrieving post codes from uk-postcodes.com')
    end

    puts response

    RetrievalResult.new
  end
end
