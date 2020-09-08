#command for building customized response
class Contacts::Commands::BuildResponse < Rectify::Command
    def initialize(response)
      @response = response
    end
  
    def call
      structured_results =  build_json 
      broadcast(:ok, structured_results)
    rescue => e
        broadcast(:error, e)
    end
  
    private
  
    def build_json
        results = @response
        @contacts = []
        @notes = []
        results.map do |item| 
          if item['_index'] == 'contacts'
              @contacts.push(item['_source'])
          elsif item['_index'] == 'notes'
              @notes.push(item['_source'])
          end
        end
      {'CONTACTS': @contacts, "NOTES": @notes }
    end
  end
  