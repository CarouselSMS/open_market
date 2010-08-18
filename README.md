OpenMarket integration kit
===========================

OpenMarket integration kit is intended to help working with the OpenMarket API
from your Ruby applications.

To use the kit, you need to be a registered user of OpenMarket (http://openmarket.com)
and have Account ID and Account Password.


Installation
============

  gem install open_market


Usage
=====

    om = OpenMarket::Base.new('xxx-xxx-xxx-xxxxx', '<your_account_password>')

    # Looking up details on the phone number
    res = om.preview('+16123327465')
    if res.success?
      res.destination         # hash of destination details
      res.operator            # hash of operator details
      res.location            # hash of geographical data
    else
      res.error[:code]        # error code
      res.error[:description] # details error description
      res.error[:resolution]  #
    end


License
=======

Circuit Breaker is Copyright © 2010 [Aleksey Gureiev](mailto:spyromus@noizeramp.com) and [Recess Mobile](http://recessmobile.com/).
It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
