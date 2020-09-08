#controller for contacts
class ContactsController < ApplicationController
  include Rectify::ControllerHelpers

  #implemented first -- getting contacts ony along with associated notes
  def index
    response = Contact.__elasticsearch__.search(
      query: {
        multi_match: {
          query: params[:query],
          fields: ['first_name', 'notes.notes', 'last_name']
        }
      }
    ).results
  
    render json: {
      results: response.results,
      total: response.total
    }
  end


  #Searching multiple modals based on their indexs
  def search
    results = Elasticsearch::Model.search(params[:query], [Note, Contact]).results.to_a.map(&:to_hash)
    ::Contacts::Commands::BuildResponse.call(results) do
        on(:ok) { |response| render json: { msg: 'success', results: response } }
        on(:error) { |e| render json: { msg: 'Something went wrong', error: e } }
    end
  end

end
