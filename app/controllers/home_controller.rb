require 'guardian_api'

class HomeController < ApplicationController
  # respond_to :json
  # respond_to :html

  def index
    @people = Entity.where(:entity_type => 'Person').order('name ASC')
    #@people = Entity.joins(:article_entities).where("entity_type = 'Person' AND articles_entities.").order('name ASC')
    if p_id = params[:person]
      @person = Entity.find(p_id)
    else
      @person = @people.first
    end
    entity = Entity.where(:name => @person.name).first
    @data = ArticleEntity.joins(:article).where(:entity_id => entity.id).order('articles.date ASC')
  end

  def index2
    @people = Entity.where(:entity_type => 'Person').order('name ASC')
    
    #@person1 = (p1_id = params[:person1] ? Entity.find(p1_id) : @people.first)
    if p1_id = params[:person1]
      @person1 = Entity.find(p1_id)
    else
      @person1 = @people.first
    end
    #@person2 = (p2_id = params[:person2] ? Entity.find(p2_id) : @people.last)
    if p2_id = params[:person2]
      @person2 = Entity.find(p2_id)
    else
      @person2 = @people.first
    end
    
    
    entity1 = Entity.where(:name => @person1.name).first
    entity2 = Entity.where(:name => @person2.name).first
    @data1 = ArticleEntity.joins(:article).where(:entity_id => entity1.id).order('articles.date ASC')
    @data2 = ArticleEntity.joins(:article).where(:entity_id => entity2.id).order('articles.date ASC')
  end
end
