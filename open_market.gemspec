$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

include_files = ["README*", "MIT-LICENSE", "{lib,spec}/**/*"].map do |glob|
  Dir[glob]
end.flatten

spec = Gem::Specification.new do |s|
  s.name              = "open_market"
  s.version           = "1.0"
  s.author            = "Aleksey Gureiev"
  s.email             = "spyromus@noizeramp.com"
  s.homepage          = ""
  s.description       = "OpenMarket integration kit"
  s.platform          = Gem::Platform::RUBY
  s.summary           = "OpenMarket integration kit"
  s.files             = include_files
  s.require_path      = "lib"
  s.test_files        = Dir["spec/**/*_spec.rb"]
  s.rubyforge_project = "open_market"
  s.has_rdoc          = true
  s.extra_rdoc_files  = Dir["README*"]
  s.rdoc_options << '--line-numbers' << '--inline-source'
end
