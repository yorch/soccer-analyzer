class ArticleEntity < ActiveRecord::Base
  belongs_to :article
  belongs_to :entity
  attr_accessible :sentiment

  def date
    article.date
  end
end
