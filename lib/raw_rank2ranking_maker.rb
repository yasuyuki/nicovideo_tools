require 'lightcsv'
require 'rubygems'
require 'nicovideo'

def write_to_rank(file, r, count)
  file.puts("#{r[8]}	#{count}	#{r[6].split(/:/)[1]}		#{r[5].split(/:/)[1]}		#{sprintf "%10.2f", r[6].split(/:/)[1].to_i == 0 ? 0 : (r[5].split(/:/)[1].to_f / r[6].split(/:/)[1].to_f) * 100}	#{r[4].split(/ /)[0]}	#{r[3]}	#{r[9]}		#{r[7]}		")
#  file.puts("#{r[8]}	#{count}	#{r[6].split(/:/)[1]}		#{r[5].split(/:/)[1]}		#{r[6].split(/:/)[1].to_i == 0 ? 0 : (r[5].split(/:/)[1].to_f / r[6].split(/:/)[1].to_f) * 100}	#{r[4].split(/ /)[0]}	#{r[3]}	#{r[9]}		#{r[7]}		")
end

def write_to_avisynth(file, r, count)
  file.puts "フレーム付動画 #{count}.png #{r[8]}.avi #{r[8]}.wav 20"
end

count = 0
first_line = true
rank_file = File.open(ARGV[0] + ".rank", "w")
avisynth_file = File.open(ARGV[0] + ".avisynth", "w")
avisynth_file.puts "framenumber 29.97"
client = Nicovideo::Thumbnail.new

LightCsv.foreach(ARGV[0]) do |row|
  if first_line then
    first_line = false
    next
  end
  next if row[13] == "○" || (row[8][0, 2] != 'sm' && row[8][0, 2] != 'nm')
  
  count += 1

  break if count > 100

  info = client.get(row[8])

  row[9] = info["first_retrieve"]

  write_to_rank(rank_file, row, count)
  write_to_avisynth(avisynth_file, row, count)

  sleep 1
  #p row # => 配列
end
