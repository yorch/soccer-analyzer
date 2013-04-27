require 'httparty'

class GuardianAPI
  include HTTParty
  base_uri 'http://content.guardianapis.com'
  
  def initialize
    if defined?(GUARDIAN_CONTENT_API_KEY)
      key = GUARDIAN_CONTENT_API_KEY
    end
    self.class.default_params "api-key" => key, "format" => "json"
  end

  def self.search_articles(search_term, section, page = 1)
    query = {}
    if defined?(GUARDIAN_CONTENT_API_KEY)
      query['api-key'] = GUARDIAN_CONTENT_API_KEY
    end
    query['q'] = search_term
    query['show-fields'] = 'trailText,headline,body,strap,lastModified,standfirst'
    query['section'] = section
    query['page-size'] = 50
    query['page'] = page
    query[:format] = "json"

    response = self.get("/search", :query => query)
  end

end