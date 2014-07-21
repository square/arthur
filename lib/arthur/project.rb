require_relative 'api'

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

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def errors
      Arthur::Api.get("/projects/#{@data['id']}/errors").map do |project|
        Arthur::Error.new(project)
      end
    end
  end
end
