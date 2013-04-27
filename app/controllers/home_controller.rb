require 'guardian_api'

class HomeController < ApplicationController
  # respond_to :json
  # respond_to :html

  def index
    @person = 'Alan Pardew'
    entity = Entity.where(:name => @person).first
    @data = ArticleEntity.where(:entity_id => entity.id).order('article.date')
  end

  def get_data
    entity = Entity.where(:name => 'Alan Pardew').first
    data = ArticleEntity.where(:entity_id => entity.id)
    # respond_to do |format|
    #   #format.json { render :json => data }
    #   format.json { render :file => "get_data.json.erb", :content_type => 'application/json' }
    # end
    render :file => "get_data.json.erb", :content_type => 'application/json'

    # respond_with({
    #   :data => data.as_json(:only => [:date, :sentiment], :methods => [:date]),
    # })
  end

  def search_guardian_api
    @count = 0
    
    # articles = GuardianContent::Content.search("football",
    #   :conditions => { :section => "football" },
    #   :select => { :fields => :all }, :limit => 50)
    # articles.each do |guardian_article|
    #   original_id = guardian_article.id
    #   if Article.where(:original_id => original_id).count == 0
    #     @count += 1
    #     article = Article.new
    #     article.source = "Guardian API"
    #     article.original_id = original_id
    #     #article.date = guardian_article.date
    #     article.url = guardian_article.url
    #     article.title = guardian_article.title
    #     article.data = guardian_article.fields
    #     article.content = guardian_article.fields['body']
    #     article.save
    #   end
    # end

    is_end = false
    page = 1
    while page < 5 && !is_end
      response = GuardianAPI.search_articles('"match report"', 'football', page)

      if response['response']['status'] == "ok"
        response = response['response']

        total_pages = response['pages'].to_i
        current_page = response['currentPage'].to_i
        page_size = response['pageSize']
        is_end = true if current_page == total_pages

        response['results'].each do |result|
          original_id = result['id']
          if Article.where(:original_id => original_id).count == 0
            @count += 1
            article = Article.new
            article.source = "Guardian API"
            article.original_id = original_id
            article.date = result['webPublicationDate'].to_datetime
            article.url = result['webUrl']
            article.title = result['webTitle']
            article.data = result['fields']
            #article.content = strip_tags(result['fields']['body'])
            article.content = result['fields']['body']
            article.save
          end
        end
      end
      page += 1
    end
  end
end
