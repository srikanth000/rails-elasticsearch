class Note < ApplicationRecord
  belongs_to :contact

  after_save :index_contact_in_elasticsearch


  private

  def index_contact_in_elasticsearch
    Contact.find_each { |contact| contact.__elasticsearch__.index_document }
  end
  
end
