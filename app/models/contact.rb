require 'elasticsearch/model'


class Contact < ApplicationRecord
    has_many :notes

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def as_indexed_json(options = {})
      self.as_json(
        only: [:id, :first_name, :last_name],
        include: {
          note: { only: [:id, :notes] }
        })
    end 

end
