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
  # TODO: paging, if we have more than 1000.
  all = []
  0.step do |i| 
    url = "http:""//localhost:8983/solr/blacklight-core/select?q=#{field}_b%3Atrue&start=#{i*1000}&rows=1000&fl=id&wt=json&indent=true"
    curl = Curl::Easy.http_get(url)
    curl.perform
    json = curl.body_str
    chunk = JSON.parse(json)['response']['docs'].map{ |o| o['id'] }
    all += chunk
    break if chunk.empty?
  end
  all.sort
end
  
#File.write('/tmp/boston-local-thumb-ids.txt', s3_ls_a('thumb/').join("\n"));
#File.write('/tmp/boston-local-video-ids.txt', s3_ls_a('video/').join("\n"));
File.write('/tmp/boston-local-solr-video-ids.txt', solr_ls_a('video').join("\n"))

