module OpenMarket
  class Base
    
    def initialize(account_id, account_password, options = {})
      @account_id = account_id
      @account_password = account_password

      @server = options[:server] || 'smsc-01.openmarket.com'
      @path   = options[:path] || '/wmp'
    end
    
    def preview(phone_number)
      request(:type => 'preview', :destination => { :address => phone_number })
    end
    
    private
    
    def xml_packet(options = {})
      d = REXML::Document.new
      d << REXML::XMLDecl.new

      request = d.add_element 'request', 'version' => "3.0", 'protocol' => "wmp", 'type' => options[:type]
      request.add_element 'account', 'id' => @account_id, 'password' => @account_password
      
      if (dest = options[:destination])
        request.add_element 'destination', 'ton' => (dest[:ton] || 0), 'address' => dest[:address]
      end

      d.to_s
    end
    
    def request(options = {})
      response = nil

      Net::HTTP.start(@server) do |q|
        response = q.post(@path, xml_packet(options), { 'Content-Type' => 'text/xml' }).body
      end

      Response.new(response)
    end
  end
end