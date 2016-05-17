require 'open-uri'
require 'json'

# We should only need to run this script once to migrate to s3.

json = URI.parse('http://localhost:8983/solr/blacklight-core/select?q=video_s%3A*+OR+image_s%3A*&rows=1000&fl=id%2Cvideo_s%2Cimage_s&wt=json&indent=true').read()
resp = JSON.parse(json)

def url_to_file(url, path)
  return if File.exists?(path)
  File.open(path, 'w') {|o|
    open(url, 'Referer' => 'http://bostonlocaltv.org/') {|f|
      o.write(f.read)
    } rescue puts "MISSING: #{url}"
  }
end

resp['response']['docs'].each do |doc|
  puts doc['id']
  video_url = 'http://mlamedia01.wgbh.org/bostonlocaltv/' + doc['video_s'].first
  thumb_url = 'http://mlamedia01.wgbh.org/bostonlocaltv/' + doc['image_s'].first
  url_to_file(video_url, '/Users/chuck_mccallum/bostonlocal-media/video/' + doc['id'] + '.mp4')
  url_to_file(thumb_url, '/Users/chuck_mccallum/bostonlocal-media/thumb/' + doc['id'] + '.jpg')
# All the files have the expected extensions.
#  unless doc['video_s'].first =~ /\.mp4$/ or doc['image_s'].first =~ /\.jpg$/
#    warn doc['id'], doc['video_s'].first, doc['image_s'].first
#  end
end
