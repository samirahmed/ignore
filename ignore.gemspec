Gem::Specification.new do |s|
  s.name        = 'ignore'
  s.version     = '0.0.1'
  s.executables << 'gitignore'
  s.date        = '2013-03-06'
  s.summary     = "Super easy way to manage gitignores from github/gitignore"
  s.description = "Super easy manage gitignores from Github.com/github or add your own custom one"
  s.authors     = ["Samir Ahmed"]
  s.email       = 'samirahmed2013@gmail.com'
  s.files       = ["lib/ignore.rb"]
  s.homepage    = 'http://github.com/samirahmed/ignore'
  
# runtime dependencies
  s.add_runtime_dependency("httparty","~> 0.10.2")
  s.add_runtime_dependency("rubyzip", "~> 0.9.9")

# development dependencies
  s.add_development_dependency("rake","~>0.9.2")

end
