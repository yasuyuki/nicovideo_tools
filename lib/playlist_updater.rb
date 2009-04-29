require 'rubygems'
require 'nicovideo'
require 'movie_id2html'
require 'mylist_just_added'

# set account
mail = ARGV.shift
password = ARGV.shift
mylist_id = ARGV.shift
videos = ARGV

# create instance
nv = Nicovideo.new(mail, password)

ml = nv.mylist(mylist_id)

videos.each do |video|
  begin
    video_page = ml.add(video).just_added
  rescue
    print "*"
    begin
      video_page = nv.watch(video)
    rescue
    end
  end
  puts video_page ? video_page.html : video
  sleep 20
end
