class RetrievalResult
  attr_reader :result_code, :error, :latitude,
              :easting, :northing, :constituency_title,
              :district_title, :ward_title

  def initialize
    @result_code = 0
    @error = ''
    @latitude = nil
    @easting = nil
    @northing = nil
    @constituency_title = nil
    @district_title = nil
    @ward_title = nil
  end
end