class ContactsController < ApplicationController


  #implemented first 
  def index
    response = Contact.__elasticsearch__.search(
      query: {
        multi_match: {
          query: params[:query],
          fields: ['first_name', 'notes.notes', 'last_name'],
          default_operator: 'and'
        }
      }
    ).results
  
    render json: {
      results: response.results,
      total: response.total
    }
  end


  def search
    results = Elasticsearch::Model.search(params[:query], [Note, Contact]).results
    render json: {
      results: results
    }
  end

end
