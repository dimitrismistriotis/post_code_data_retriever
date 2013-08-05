# PostCodeDataRetriever

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'post_code_data_retriever'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install post_code_data_retriever

## Usage

Require the gem if not done from it's environment

  post_code_data = PostCodeDataRetriever.get_coordinates('WC1B3DG')

### Return values
Returns instance of RetrievalResult class with the following attributes:

* result_code: 0 correct negative for error, see below fow details.
* error: Description of error (for negative values of result code).
* latitude
* longitude
* easting
* northing
* constituency_title
* district_title
* ward_title

One of the following:

*  0: All OK
* -1: Invalid post code provided.
* -2: Connection error.
* -4: Correct post code, but for non-existing area.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
