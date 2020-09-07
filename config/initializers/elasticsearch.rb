Elasticsearch::Model.client = Elasticsearch::Client.new({
  log: true
})

# unless Contact.__elasticsearch__.index_exists?   
#   Contact.__elasticsearch__.create_index! force: true 
#   Contact.import 
# end