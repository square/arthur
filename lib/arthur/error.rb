require_relative 'api.rb'

module Arthur
  class Error
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def self.fetch(error_id)
      Arthur::Error.new(Arthur::Api.get("/errors/#{error_id}"))
    end

    def count_in_environment(env)
      if @data['release_stages'][env]
        return @data['release_stages'][env]
      else
        return 0
      end
    end
  end
end
