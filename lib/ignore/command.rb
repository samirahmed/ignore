module Ignore
  class Command
    class << self 
      
      def execute(*args)
        first = args.shift
        second = args.shift
        delegate( first , second )
      end   
  
      def delegate( first, second )
        return help                   if first == 'help'
        return clean                  if first == 'clean'
        return update                 if first == 'update'
        return saveas(second)         if first == 'saveas' and second
        return getfile(second,:show)  if first == 'show' and second
        return getfile(first,:append) if first and second.nil?
        return help
      end

      def show
        
      end

      def input
        $stdin
      end

      def output(s)
        puts(s)
      end

      def getfile(language, callback)
        storage = Storage.new
        exact = storage.match(language)
        
        return self.send(callback, storage, exact.first) unless exact.empty? 

        loose = storage.match(language, false)
        
        case
          when loose.length  < 1
            output("No such gitignore #{language}")
          
          when loose.length == 1
            self.send( callback , storage, loose.first )
          
          when (loose.length > 1 and loose.length < 5)
            output "Please specify: \n#{loose.reduce(""){|res,name| res+=item+"\n"}}"
          
          when loose.length > 5
            output "Please be more specific"
          
          else
            output("uh-oh? something went wrong")
        end

      end

      def show(storage,name)
        contents = storage.load(name)
        output(contents)
      end

      def append(storage, name)
        contents = storage.load(name)
        gitignore = Gitignore.new
        gitignore.append(contents)
      end

      def update
        Storage.new.update
      end

      def clear
        Storage.new.clear
      end

      def saveas( name )
        gitignore = Gitignore.new
        storage = Storage.new
        
        return storage.write(name,gitignore.read) if gitignore.exists?
        return output ("No .gitignore found in the #{gitignore.path}")
      end

      def help()
        text= %{
          ignore : help -------------------------------------------------------

          ignore <language>           append the specified language's gitignore to current directory     
          ignore show <language>      print the language to STDOUT (suggested use with '| less')
          ignore update               update from github.com/github/gitignore
          ignore clear                clear your local ~/.ignores folder
          ignore saveas <filename>    save working directories gitignore to local ~/.ignores folder
          ignore help                 show help

          see https://github.com/samirahmed/ignore for more documentation
          }
        output(text)
      end

    end
  end
end
