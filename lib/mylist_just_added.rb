require 'rubygems'
require 'nicovideo'

module Nicovideo
  class MyList
    def just_added
      @videos.last
    end
  end
end
