require 'aws-sdk'
require 'json'
require 'curl'

Aws.config[:region] = 'us-east-1'

def s3_ls_a(prefix)
  all = []
  token = nil
  1.step do
    response = Aws::S3::Client.new().list_objects_v2(bucket: 'bostonlocaltv.org', prefix: prefix, max_keys: 1000, continuation_token: token)
    chunk = response.contents.map{ |o| o.key.sub(prefix, '').sub('.jpg', '') }
    all += chunk
    token = response.next_continuation_token
    break unless response.is_truncated
    sleep 1
  end
  all.sort
end

def solr_ls_a(field)
  all = []
  0.step do |i| 
    url = "http:""//localhost:8983/solr/blacklight-core/select?q=video_b:true&start=#{i*1000}&rows=1000&fl=#{field}&wt=json&indent=true"
    puts url
    curl = Curl::Easy.http_get(url)
    curl.perform
    json = curl.body_str
    chunk = JSON.parse(json)['response']['docs'].map{ |o| o[field] }
    all += chunk
    break if chunk.empty?
  end
  all.sort
end

def solr_to_s3()
  all = []
  0.step do |i| 
    url = "http:""//localhost:8983/solr/blacklight-core/select?q=video_b:true&start=#{i*1000}&rows=1000&fl=image_s,video_s,id&wt=json&indent=true"
    puts url
    curl = Curl::Easy.http_get(url)
    curl.perform
    json = curl.body_str
    chunk = JSON.parse(json)['response']['docs'].map{ |o| "curl --referer http://bostonlocaltv.org http://mlamedia01.wgbh.org/bostonlocaltv/#{o['image_s'].first} > /tmp/thumb/#{o['id']}.jpg; aws s3 mv /tmp/thumb/#{o['id']}.jpg s3://bostonlocaltv.org/thumb/#{o['id']}.jpg" }
    all += chunk
    break if chunk.empty?
  end
  all.sort
end
  
#File.write('/tmp/boston-local-thumb-ids.txt', s3_ls_a('thumb/').join("\n"));
#File.write('/tmp/boston-local-video-ids.txt', s3_ls_a('video/').join("\n"));
#File.write('/tmp/boston-local-solr-thumb-urls.txt', solr_ls_a('image_s').join("\n"))

File.write('/tmp/boston-local.sh', solr_to_s3().join("\n"))

