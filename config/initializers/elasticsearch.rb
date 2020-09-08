config = {
  host: "http://localhost:9200/",
  transport_options: {
    request: { timeout: 5 }
  },
}

if File.exists?("config/elasticsearch.yml")
  config.merge!(YAML.load_file("config/elasticsearch.yml").symbolize_keys)
end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)


# Elasticsearch::Model.client = Elasticsearch::Client.new({
#   log: true
# })

# unless Contact.__elasticsearch__.index_exists?   
#   Contact.__elasticsearch__.create_index! force: true 
#   Contact.import 
# end