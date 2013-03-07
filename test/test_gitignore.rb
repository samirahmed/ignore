require_relative 'helper'

class TestGitIgnore< Test::Unit::TestCase

    def setup
      @gitignore = Ignore::Gitignore.new
    end
    
    def teardown
      FileUtils.rm @gitignore.path
    end

    def test_append
      @gitignore.append("hello\nworld\n","mylang")
      assert(@gitignore.read.split("\n").length == 7)
    end

    def test_exists
      assert( !@gitignore.exists?)
      FileUtils.touch @gitignore.path
      assert( @gitignore.exists? )
    end

end
