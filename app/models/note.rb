class Note < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # include Searchable -- have to implement later

  belongs_to :contact

  mappings dynamic: 'false' do 
      indexes :id
      indexes :notes, analyzer: 'english'
  end

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :notes])
  end   
end
