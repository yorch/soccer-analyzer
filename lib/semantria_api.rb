require 'semantria/authrequest'
require 'semantria/jsonserializer'
require 'semantria/session'
require 'semantria/version'

class SessionCallbackHandler < Semantria::CallbackHandler
  def onRequest(sender, args)
    #puts "Request: ", args
  end

  def onResponse(sender, args)
    #puts "Response: ", args
  end

  def onError(sender, args)
    puts 'Error: ', args
  end

  def onDocsAutoResponse(sender, args)
    #puts "DocsAutoResponse: ", args.length, args
  end

  def onCollsAutoResponse(sender, args)
    #puts "CollsAutoResponse: ", args.length, args
  end
end

class SemantriaAPI
  # the consumer key and secret
  @@consumer_key = 'c18c1d22-e189-4a92-b34d-dc1155964446'
  @@consumer_secret = 'e7faedd6-70c2-487f-a43a-ad89aebf04e9'

  def self.request
    # Initializes new session with the keys and app name.
    # We also will use compression.
    session = Semantria::Session.new(@@consumer_key, @@consumer_secret, 'TestApp', true)
    # Initialize session callback handlers
    #callback = SessionCallbackHandler.new()
    callback = SessionCallbackHandler.new()
    session.setCallbackHandler(callback)

    Article.where { id.not_in Article.where("extra_data ? 'sematria_status'") }.each do |article|
      # Creates a sample document which need to be processed on Semantria
      # Unique document ID
      doc = {
        #'id' => Digest::MD5.hexdigest(article.original_id + "/SoccerAnalyzer"),
        #'id' => article.original_id,
        'id' => "soccer-article-#{article.id}",
        'text' => article.content.slice(0, 8000) }
      # Queues document for processing on Semantria service
      status = session.queueDocument(doc)
      # Check status from Semantria service
      if status == 202
        puts 'Document ', doc['id'], ' queued successfully.'
        article.extra_data['semantria_status'] = :sent
        article.extra_data['semantria_sent_at'] = Time.new
        article.save
      end
    end
  end

  def self.retrieve
    # Initializes new session with the keys and app name.
    # We also will use compression.
    session = Semantria::Session.new(@@consumer_key, @@consumer_secret, 'TestApp', true)
    # Initialize session callback handlers
    callback = SessionCallbackHandler.new()
    session.setCallbackHandler(callback)

    Article.where("extra_data -> 'semantria_status' = 'sent'").each do |article|
      data = session.getDocument("soccer-article-#{article.id}")
      
      puts "Using article #{article.title}"
        
      data['entities'].nil? or data['entities'].each do |raw_entity|
        # Find or create entities
        entity = Entity.where(:name => raw_entity['title'], :entity_type => raw_entity['entity_type']).first
        if !entity
          entity = Entity.create(:name => raw_entity['title'], :entity_type => raw_entity['entity_type'])
          puts "Creating new Entity #{entity.name} (#{entity.entity_type})"
        end

        # Create ArticleEntity instance and article, entity, sentiment
        article_entity = ArticleEntity.new
        article_entity.article = article
        article_entity.entity = entity
        article_entity.sentiment = raw_entity['sentiment_score'].to_f
        article_entity.save
      end

      article.extra_data['semantria_status'] = :received
      article.extra_data['semantria_retrieved_at'] = Time.new
      article.save
    end
  end

  # def self.retrieve
  #   # Initializes new session with the keys and app name.
  #   # We also will use compression.
  #   session = Semantria::Session.new(@@consumer_key, @@consumer_secret, 'TestApp', true)
  #   # Initialize session callback handlers
  #   callback = SessionCallbackHandler.new()
  #   session.setCallbackHandler(callback)

  #   length = 10
  #   results = []

  #   while results.length < length
  #     # As Semantria isn't real-time solution you need to wait some time before getting of the processed results
  #     # In real application here can be implemented two separate jobs, one for queuing of source data another one for retreiving
  #     # Wait ten seconds while Semantria process queued document
  #     #  sleep(10)
  #     # Requests processed results from Semantria service
  #     status = session.getProcessedDocuments()
  #     # Check status from Semantria service
  #     status.is_a? Array and status.each do |object|
  #       results.push(object)
  #     end
  #     print status.length, ' documents received successfully.', "\r\n"
  #   end

  #   results.each do |data|
  #     #article = Article.where(:original_id => data['id']).first
  #     article = Article.find(data['id']).first

  #     if true #article
  #       puts "Using article #{article.title}"
        
  #       data['entities'].nil? or data['entities'].each do |raw_entity|
  #         # Find or create entities
  #         entity = Entity.where(:name => raw_entity['title'], :type => raw_entity['entity_type']).first
  #         if !entity
  #           entity = Entity.create(:name => raw_entity['title'], :type => raw_entity['entity_type'])
  #           puts "Creating new Entity #{entity.name} (#{entity.type})"
  #         end

  #         # Create ArticleEntity instance and article, entity, sentiment
  #         article_entity = ArticleEntity.new
  #         article_entity.article = article
  #         article_entity.entity = entity
  #         article_entity.sentiment = raw_entity['sentiment_score'].to_f
  #         article_entity.save
  #       end
  #     end
  #   end
  # end
end