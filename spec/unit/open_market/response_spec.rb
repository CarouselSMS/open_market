require File.dirname(__FILE__) + '/../../spec_helper'

describe OpenMarket::Response do
  
  describe "when receiving preview responses" do
    it "should parse successful" do
      xml = '<?xml version="1.0"?><response version="3.0" protocol="wmp" type="preview"><error code="0" description="No Error" resolution=""/><destination country_code="1" national_number="6147389968" intl_notation="+16147389968" area_code="614" area_code_length="3" num_min_length="7" num_max_length="7" na_nxx="738" na_line="9968" local_notation="(614) 738-9968" local_format="(###) ###-####" digits_all="11" digits_local="10" ported="false" ported_from="0"/><location zone="1" zone_name="North America, Caribbean" country="US" country_name="United States" region="OH" region_name="Ohio" city="Columbus" timezone_min="-5" timezone_max="-5" estimated_latitude="39.96" estimated_longitude="-83.00"/><operator  id="77" name="Verizon" text_length="160" binary_length="0" unicode_length="0" binary="false" unicode="false" smart_messaging="false" wap_push="false" ems="false" price="0.0320" price_currency="USD" price_plan="Dedicated" price_tier="1"/></response>'
      r = OpenMarket::Response.new(xml)
      r.should be_success

      r.error[:code].should           == 0
      r.error[:description].should    == "No Error"
      r.error[:resolution].should     == ""
      
      d = r.destination
      d[:country_code].should         == 1
      d[:national_number].should      == "6147389968"
      d[:intl_notation].should        == "+16147389968"
      d[:area_code].should            == "614"
      d[:area_code_length].should     == 3
      d[:num_min_length].should       == 7
      d[:num_max_length].should       == 7
      d[:na_nxx].should               == "738"
      d[:na_line].should              == "9968"
      d[:local_notation].should       == "(614) 738-9968"
      d[:local_format].should         == "(###) ###-####"
      d[:digits_all].should           == 11
      d[:digits_local].should         == 10
      d[:ported].should               == false
      d[:ported_from].should          == 0
      
      l = r.location
      l[:zone].should                 == 1
      l[:zone_name].should            == "North America, Caribbean"
      l[:country].should              == "US"
      l[:country_name].should         == "United States"
      l[:region].should               == "OH"
      l[:region_name].should          == "Ohio"
      l[:city].should                 == "Columbus"
      l[:timezone_min].should         == "-5"
      l[:timezone_max].should         == "-5"
      l[:estimated_latitude].should   == "39.96"
      l[:estimated_longitude].should  == "-83.00"
      
      o = r.operator
      o[:id].should                   == 77
      o[:name].should                 == "Verizon"
      o[:text_length].should          == 160
      o[:binary_length].should        == 0
      o[:unicode_length].should       == 0
      o[:binary].should               == false
      o[:unicode].should              == false
      o[:smart_messaging].should      == false
      o[:wap_push].should             == false
      o[:ems].should                  == false
      o[:price].should                == 0.032
      o[:price_currency].should       == "USD"
      o[:price_plan].should           == "Dedicated"
      o[:price_tier].should           == 1
    end
    
    it "should parse error" do
      xml = '<?xml version="1.0"?><response version="3.0" protocol="wmp" type="preview"><error code="345" description="Unable to determine carrier id from pin or destination address." resolution=""/></response>'
      r = OpenMarket::Response.new(xml)
      
      r.should_not be_success
      
      r.error[:code].should           == 345
      r.error[:description].should    == "Unable to determine carrier id from pin or destination address."
      r.error[:resolution].should     == ""
    end
    
  end
  
end