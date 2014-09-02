require "rubygems"
require "json"
require "net/http"
require "uri"
require "resolv"

empty = "There are no distributed applications registered in Consul"
 
uri = URI.parse("http://consul.service.consul:8500/v1/catalog/service/distributed_app")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

while true
  if response.body == "{}"
    puts empty
    sleep(1)
  elsif
    result = JSON.parse(response.body)
    result.each do |service|
      puts "Application #{service['ServiceName']} with element #{service["ServiceID"]} on port #{service["ServicePort"]} found on node #{service["Node"]} (#{service["Address"]})."
      dns = Resolv::DNS.new.getresources("distributed_app.service.consul", Resolv::DNS::Resource::IN::A)
      puts "We can also resolve DNS - #{service['ServiceName']} resolves to #{dns.collect { |d| d.address }.join(" and ")}."
      sleep(1)
    end
  end
end
