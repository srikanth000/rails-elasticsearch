require 'elasticsearch/model'


class Contact < ApplicationRecord
    has_many :notes

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # index_name([Rails.env,base_class.to_s.pluralize.underscore].join('_'))

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :id, analyzer: 'english'
        indexes :first_name, analyzer: 'english'
        indexes :last_name, analyzer: 'english'
        indexes :notes do
          indexes :id, analyzer: 'english'
          indexes :notes, analyzer: 'english'
        end

      end
    end


    def as_indexed_json(options = {})
      self.as_json(
        only: [:id, :first_name, :last_name],
        include: {
          notes: { only: [:id, :notes] }
        })
    end 

end
