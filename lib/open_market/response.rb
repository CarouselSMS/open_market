module OpenMarket
  class Response
    
    attr_reader :error, :destination, :location, :operator

    def initialize(xml)
      @doc = REXML::Document.new(xml)
      puts xml
      
      get_error
      get_destination
      get_location
      get_operator
    end

    def success?
      @error && @error[:code] == 0
    end
    
    private
    
    def get_error
      el = @doc.root.elements['error']
      @error = {
        :code         => el.attributes['code'].to_i,
        :description  => el.attributes['description'],
        :resolution   => el.attributes['resolution'] }
    end
    
    def get_destination
      el = @doc.root.elements['destination']
      return if el.nil?
      
      @destination = {
        :country_code         => el.attributes['country_code'].to_i,
        :national_number      => el.attributes['national_number'],
        :intl_notation        => el.attributes['intl_notation'],
        :area_code            => el.attributes['area_code'],
        :area_code_length     => el.attributes['area_code_length'].to_i,
        :num_min_length       => el.attributes['num_min_length'].to_i,
        :num_max_length       => el.attributes['num_max_length'].to_i,
        :na_nxx               => el.attributes['na_nxx'],
        :na_line              => el.attributes['na_line'],
        :local_notation       => el.attributes['local_notation'],
        :local_format         => el.attributes['local_format'],
        :digits_all           => el.attributes['digits_all'].to_i,
        :digits_local         => el.attributes['digits_local'].to_i,
        :ported               => el.attributes['ported'] == 'true',
        :ported_from          => el.attributes['ported_from'].to_i }
    end
    
    def get_location
      el = @doc.root.elements['location']
      return if el.nil?

      @location = {
        :zone                 => el.attributes['zone'].to_i,
        :zone_name            => el.attributes['zone_name'],
        :country              => el.attributes['country'],
        :country_name         => el.attributes['country_name'],
        :region               => el.attributes['region'],
        :region_name          => el.attributes['region_name'],
        :city                 => el.attributes['city'],
        :timezone_min         => el.attributes['timezone_min'],
        :timezone_max         => el.attributes['timezone_max'],
        :estimated_latitude   => el.attributes['estimated_latitude'],
        :estimated_longitude  => el.attributes['estimated_longitude'] }
    end
    
    def get_operator
      el = @doc.root.elements['operator']
      return if el.nil?

      @operator = {
        :id                   => el.attributes['id'].to_i,
        :name                 => el.attributes['name'],
        :text_length          => el.attributes['text_length'].to_i,
        :binary_length        => el.attributes['binary_length'].to_i,
        :unicode_length       => el.attributes['unicode_length'].to_i,
        :binary               => el.attributes['binary'] == 'true',
        :unicode              => el.attributes['unicode'] == 'true',
        :smart_messaging      => el.attributes['smart_messaging'] == 'true',
        :wap_push             => el.attributes['wap_push'] == 'true',
        :ems                  => el.attributes['ems'] == 'ems',
        :price                => el.attributes['price'].to_f,
        :price_currency       => el.attributes['price_currency'],
        :price_plan           => el.attributes['price_plan'],
        :price_tier           => el.attributes['price_tier'].to_i }
    end
  end
end