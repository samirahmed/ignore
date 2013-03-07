module Ignore
  class Command
    class << self 
      
      def execute(*args)
        first = args.shift
        second = args.shift
        delegate(first, second)
      end   
  
      def delegate(first, second)
        return help                   if first == 'help'
        return list                   if first == 'list'
        return clean                  if first == 'clean'
        return update                 if first == 'update'
        return saveas(second)         if first == 'saveas' and second
        return getfile(second,:show)  if first == 'show' and second
        return getfile(first,:append) if first and second.nil?
        
        storage #fetch and print help
        help
      end

      def list
        list = storage.list
        output( list.reduce(""){|res,line| res+= line.chomp('.gitignore')+"\n" })
      end

      def getfile(language, callback)
        exact = storage.match(language)
        
        return self.send(callback, exact.first) unless exact.empty? 

        loose = storage.match(language, false)
        
        case
          when loose.length  < 1
            output("No such gitignore #{language}")
          
          when loose.length == 1
            self.send( callback, loose.first )
          
          when (loose.length > 1 and loose.length < 5)
            output "Please specify: \n#{loose.reduce(""){|res,name| res+=name+"\n"}}"
          
          when loose.length > 5
            output "Please be more specific"
          
          else
            output("uh-oh? something went wrong")
        end

      end

      def show(name)
        contents = storage.load(name)
        output(contents)
      end

      def append(name)
        contents = storage.load(name)
        gitignore.append(contents,name)
      end

      def update
        storage.update
      end

      def clean
        storage.clear
      end

      def saveas( name )
        return storage.write(name,gitignore.read) if gitignore.exists?
        return output("No .gitignore found in the #{gitignore.path}")
      end

      def help()
        text= %{
  ignore : help -------------------------------------------------------

  ignore <language>           add specified languages gitignore to working directory
  ignore list                 list available gitignores
  ignore show <language>      print the language to STDOUT (use with '| less')
  ignore update               update from github.com/github/gitignore
  ignore clean                empty your local ~/.ignores folder
  ignore help                 show help

  see https://github.com/samirahmed/ignore for more documentation
          }
        output(text)
      end

      def storage
        @storage ||= Storage.new
      end

      def gitignore
        @gitignore ||= Gitignore.new
      end
      
      def input
        $stdin
      end

      def outprint(s)
        print(s)
      end
      
      def output(s)
        puts(s)
      end

    end
  end
end
