# frozen_string_literal: true


# class will be inherited by individual api clients
require 'net/http'

class ApplicationClient
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def get(path, query: {})
    make_request(Net::HTTP::Get, path, query:)
  end

  def post(path, query: {}, body: {})
    make_request(Net::HTTP::Post, path, query:, body:)
  end

  def patch(path, query: {}, body: {})
    make_request(Net::HTTP::Patch, path, query:, body:)
  end

  def put(path, query: {}, body: {} )
    make_request(Net::HTTP::Put, path, query:, body:)
  end

  def delete(path, query: {})
    make_request(Net::HTTP::Delete, path, query:)
  end

  private

  # check calling class and use the defined BASE_URL constant
  def base_uri
    self.class::BASE_URL
  end

  # this method can be overriden in individual client in order to pass any other custom headers eg different form of auth
  def default_headers
    {
      'Authorization': "bearer #{@token}",
      'Accept': 'application/json'
    }
  end

  def make_request(klass, path, query: {}, body: {})
    uri = URI("#{base_uri}#{path}")
    uri.query = Rack::Utils.build_query(query) if query.present? # use Rack::Utils.build_query to build url query params from a hash
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.instance_of?(URI::HTTPS)

    # binding.b

    request = klass.new(uri.request_uri, default_headers)

    if body.present?
      request.body = body.to_json
      request['Content-Type'] = 'application/json'
    end

    response = http.request(request)

    case response.code.to_i
    when 200..299
      JSON.parse(response.body) if response.body.present?
    else
      # binding.b
      default_parse_error_response(response)
    end
  end

  #Override this to handle different error formats
  def default_parse_error_response(response)
    raise "Error #{response.code}: #{JSON.parse(response.body)['message']
      }"
  end

  class Error < StandardError; end
end
