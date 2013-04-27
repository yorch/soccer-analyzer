require 'guardian_api'
require 'semantria_api'

namespace :external_data do
  STDOUT.sync = true
  desc "TODO"
  task :obtain_guardian_articles => :environment do
    count = 0
    is_end = false
    page = 1
    while !is_end #&& page < 5
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
            count += 1
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
            puts "Creating article #{article.title}"
          end
        end
      end
      page += 1
    end
  end

  task :send_articles_to_semantria => :environment do

  end
end
