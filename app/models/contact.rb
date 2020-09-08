require 'elasticsearch/model'


class Contact < ApplicationRecord
    has_many :notes

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    #edge_ngram
    settings index: {
      "analysis": {
        "analyzer": {
          "substring_analyzer": {
            "tokenizer": "standard",
            "filter": ["lowercase", "substring"]
          }
        },
        "filter": {
          "substring": {
            "type": "edgeNGram",
            "min_gram": 1,
            "max_gram": 3
          }
        }
      }
    } do
      mappings dynamic: 'false'  do
          indexes :first_name, analyzer: "substring_analyzer"
          indexes :last_name, analyzer: "substring_analyzer"
            indexes :notes do
              indexes :id
              indexes :notes, analyzer: "substring_analyzer"
          end
      end
    end
    
    # mappings dynamic: 'false' do 
    #   indexes :id
    #   indexes :first_name
    #   indexes :last_name
    #   indexes :notes, type: 'nested' do 
    #     indexes :id,   type: 'integer'
    #     indexes :notes
    #   end
    # end


    def as_indexed_json(options = {})
      self.as_json(
        only: [:id, :first_name, :last_name],
        include: {
          notes: { only: [:id, :notes] }
        })
    end 
     
end
