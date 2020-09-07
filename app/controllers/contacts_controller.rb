class ContactsController < ApplicationController
  def index
    response = Contact.__elasticsearch__.search(
      query: {
        multi_match: {
          query: params[:query],
          fields: ['first_name', 'notes.notes', 'last_name']
        }
      },
      highlight: {
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        fields: {
          'first_name': {},
          'last_name': {},
          'notes.notes': {}
        }
      }
    ).results
  
    render json: {
      results: response.results,
      total: response.total
    }
  end
end
