class Note < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # include Searchable -- have to implement later

  #enahancement -- Make this more coherent and dry by pushing this indexing into searchable concern

  belongs_to :contact

  mappings dynamic: 'false' do 
      indexes :id
      indexes :notes, analyzer: 'english'
  end

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :notes],
      include: {
        contact: { only: [:id, :first_name, :last_name] }
      })
  end   
end
