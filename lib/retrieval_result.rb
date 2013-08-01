class RetrievalResult
  attr_reader :error_code, :error

  def initialize
    @error_code = 0
    @error = ''
  end
end