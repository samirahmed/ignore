begin
  require 'rubygems'
  rescue LoadError
end

require 'fileutils'
require 'httparty'
require 'zip/zipfilesystem'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'ignore/command'
require 'ignore/storage'
require 'ignore/gitignore'

module Ignore

end
