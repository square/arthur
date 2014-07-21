require 'json'
require 'open-uri'
require 'rest-client'

module Arthur
  module Api
    # return JSON parsed response
    def self.get(path, opts = {})
      all_elements = []
      next_offset = nil

      loop do
        response = RestClient.get(full_path(path), 'params' => prune_options(opts.merge(offset: next_offset)))

        next_offset = nil
        if response.headers[:link]
          rel_next = response.headers[:link].match(/\<(.*)\>; rel=\"next\"/)
          if rel_next
            next_offset = URI.unescape(rel_next[1].match(/[&?]offset=([^&>]*)/)[1])
          end
        end
        json_parsed_response = JSON.parse(response.body)

        if json_parsed_response.is_a?(Array)
          all_elements += json_parsed_response
        else
          return json_parsed_response
        end
        break unless next_offset
      end

      all_elements
    end

    def self.prune_options(options={})
      options.merge(auth_token: auth_token).delete_if{ |_, value| value.nil? }
    end

    def self.full_path(path)
      "#{base_path}#{path}"
    end

    def self.configure(path, token)
      @base_path = path
      @auth_token = token
    end

    def self.base_path
      if @base_path
        @base_path
      else
        'https://api.bugsnag.com'
      end
    end

    def self.auth_token
      @auth_token
    end
  end
end
