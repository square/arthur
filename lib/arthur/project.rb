require_relative 'api.rb'

module Arthur
  class Project
    def self.list
      Arthur::Api.get("/account/projects").map do |project|
        Arthur::Project.new(project)
      end
    end

    def self.fetch(project_id)
      Arthur::Project.new(Arthur::Api.get("/projects/#{project_id}"))
    end

    def bugsnag_errors()
      Arthur::Api.get("/projects/#{@data['id']}/errors").map do |project|
        Arthur::Error.new(project)
      end
    end

    attr_reader :data

    def initialize(data)
      @data = data
    end
  end
end
