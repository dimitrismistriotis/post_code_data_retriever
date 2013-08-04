class RetrievalResult
  attr_reader :result_code, :error, :latitude, :longitude,
              :easting, :northing, :constituency_title,
              :district_title, :ward_title

  def initialize(result_code = 0, error = '', latitude = nil, longitude = nil,
    easting = nil, northing = nil, constituency_title = '', district_title = '',
    ward_title = '')
    @result_code = result_code
    @error = error
    @latitude = latitude
    @longitude = longitude
    @easting = easting
    @northing = northing
    @constituency_title = constituency_title
    @district_title = district_title
    @ward_title = ward_title
  end
end