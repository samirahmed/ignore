require_relative 'helper'

class TestStorage < Test::Unit::TestCase

    def setup
      @storage = Ignore::Storage.new
    end

    def test_load
      assert(@storage.load("ruby").split("\n").length == 18)
      assert(@storage.load("yii").split("\n").length == 3)
    end

    def test_match
      assert(@storage.match("text",true).length == 0)
      assert(@storage.match("text",false).length == 3)
    end

    def test_update
      assert(@storage.update.length > 100 )
    end
end
