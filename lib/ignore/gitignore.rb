require 'fileutils'

module Ignore
  class Gitignore
    
    def initialize
      @path = File.join(Dir.pwd(),'.gitignore')
    end

    def append( data )
      FileUtils.touch @path
      File.open(@path, 'a'){|f| f.write(data) }
    end

    def read
      return File.open(@path,'r'){|f| f.read } if exists? 
      ""
    end

    def exists?
      File.exists?( @path )
    end

    def path
      @path
    end
  end
end
