class Article < ActiveRecord::Base
  attr_accessible :source, :original_id, :date, :url, :title

  serialize :data, ActiveRecord::Coders::Hstore
  serialize :extra_data, ActiveRecord::Coders::Hstore
end
