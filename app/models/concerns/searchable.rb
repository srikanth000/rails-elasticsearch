# Searchable concern
require 'elasticsearch/model'

module Searchable
    extend ActiveSupport::Concern
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    ##under implementation -- devisng a reusable concern for both models so that we can achieve dry policy

    CONTACT_ATTRS = %i[first_name, last_name].freeze
    NOTE_ATTRS = %i[notes].freeze

    unless Rails.env.development? || Rails.env.test?
      included do
        def as_indexed_json(_options = {})
          if self.class == Contact
            as_json(only: CONTACT_ATTRS)
          elsif self.class == Note
            as_json(only: NOTE_ATTRS)
            mappings dynamic: 'false' do 
                indexes :id
                indexes :notes, analyzer: 'english'
            end
          end
        end
  
        # after_commit on: :create do
        # end
  
        # after_commit on: :update do
        # end
  
        # after_commit on: :destroy do
        # end
      end
    end
  end
  