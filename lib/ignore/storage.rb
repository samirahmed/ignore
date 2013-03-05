module Ignore
  class Storage

    GITIGNORES_ZIP = "https://github.com/github/gitignore/archive/master.zip"
   
    def initialize()
      @root ||= File.join(File.expand_path('~'),'.ignores')
      @gitignores||= File.join(@root,'/*.gitignore')
      fetch unless list
    end
    
    def root
      @root
    end
    
    def match(filetype, exact = true )
      fname = filetype.downcase
      list.select{|names| not names.downcase.scan( ( exact ? /^#{fname}$/i : /#{fname}/i )  ).empty? }  
    end
  
    def load(filetype)
      File.open( path_to(filetype) ,'r'){ |f|f.read }
    end

    def path_to(filename)
      filepath = filename.chomp(".gitignore")  
      File.join(@root, filepath+".gitignore")
    end

    def update
      fetch
    end

    def clear
      nuke_directory!
    end

    def exists?(filename)
      File.exists?( path_to(name) )
    end
  
    def write(filename, contents)
        if exists?( filename )
          outprint "Selected ignore #{name} already exists? overwrite it? [Ny]: "
          return unless input.gets.strip.downcase.split("").first == "y"
        end
        write!( filename, contents )
    end
    
    def list
      @list ||= if Dir.glob(@gitignores).length > 1
        Dir.glob(@gitignores).map{|file| file.split('/').last.gsub(/\.gitignore/,'') }
      else
        nil
      end
    end
    
    private
    
    def update!
      nuke_directory!
      fetch
    end
    
    def write!( filename, contents )
      File.open( path_to(filename) ,'w' ){|f| f.write(contents) }
    end
    
    def nuke_directory! 
      outprint "Delete all files in #{@root} ? [Ny]: "
      if input.gets.strip.downcase.split('').first == 'y'
        FileUtils.rm_rf @root 
      end
    end
    
    def input
      Command.input
    end
    
    def outprint(s)
      Command.outprint(s)
    end
    
    def output(s)
      Command.output(s)
    end
    
    def fetch
      FileUtils.mkdir @root if not Dir.exists? @root
      begin
        output "Downloading gitignores from github.com/github/gitignore"
        download = HTTParty.get(GITIGNORES_ZIP).body
      rescue Exception => ex
        output "ERROR: Unable fetch gitignores from #{GITIGNORES_ZIP}"
      end
      zipfile = File.join(@root,'ignores.zip')
      
      File.open(zipfile,'w'){|f| f.write download}
      unzip zipfile
      FileUtils.rm zipfile

      output "#{list.length} gitignores total"
      list 
    end
   
    def unzip(source , path=@root )
      Zip::ZipFile.open(source) do |zipfile|
        zipfile.each do |entry|
          if entry.name.end_with?(".gitignore")
            fpath = File.join(path, File.basename(entry.name) )
            
            File.delete(fpath) if File.exists?(fpath) # Overwrite
            zipfile.extract(entry, fpath)
          end
        end
      end
      
      rescue Zip::ZipDestinationFileExistsError => ex
    end

  end
end
