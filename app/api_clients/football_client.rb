# frozen_string_literal: true

class FootballClient < ApplicationClient
  BASE_URL = 'https://api.football-data.org/v4'

  def default_headers
    {
      'X-Auth-Token': @token,
      'Accept': 'application/json'
    }
  end

  def default_parse_error_response(response)
    raise "Error #{response.code}: #{JSON.parse(response.body)['error']
      }"
  end

  # Get all areas
  def areas
    get '/areas'
  end

  # Get a specific area by passing the id of the area. The Id can be gotten by getting all areas
  def area(id)
    get "/areas/#{id}"
  end

  def competitions(**kwargs)
    get '/competitions', query: kwargs
  end

  def competition(code)
    get "/competitions/#{code}"
  end

  # sample format of the method call: standings(2021, season: 2023, date: "2023-18-11")
  def standings(id, **kwargs)
    get "/competitions/#{id}/standings", query: kwargs
  end
end
