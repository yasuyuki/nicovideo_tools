require 'rubygems'
require 'nicovideo'

module Nicovideo
  class VideoPage
    def html(without_thumbnail = true)
      html_txt = "[#{url}:title=#{title}] <a href='http://b.hatena.ne.jp/entry/#{url}'><img src='http://b.hatena.ne.jp/entry/image/#{url}'></a>"
      html_txt << "<br><a href='#{url}'><img src='http://niconail.info/#{video_id}' alt='#{title}'></a>" unless without_thumbnail
      html_txt << "\n"

      html_txt
    end
  end
end
