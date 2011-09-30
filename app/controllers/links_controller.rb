class LinksController < ApplicationController
  #require 'rubygems'
  #require 'hpricot'
  #require 'open-uri'
  
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  def show
    @link = Link.find(params[:id])
  end
  
  def redir
    redirect_to Link.where('comp'  => params[:full_path]).first.orig and return
  end
  
  def hola
    if user_signed_in?
      if Link.where('orig' => params[:full_path], 'user_id'  => current_user.id).count != 0
        render :action => "duplicate"
        return false
      else
        @link=Link.new
        @link.orig = params[:full_path]
        #doc = Nokogiri::HTML(open(params[:full_path]))
        #@link.title = (doc.at_css("title").text).to_s
        
        #@url = params[:full_path];
        #@hp = Hpricot(open(@url))
          
        @link.title='dummy_title'
        if Link.count == 0
          @link.comp = '0'
        else
          @link.comp = (Link.last.id + 1).to_s(36)
        end
        @link.user_id = current_user.id
        @link.save
        end
      else
        puts "ciao"
        render :action => "notlogged"
        return false
    end
  end
  
  def home
    if user_signed_in?
      @links = Link.where("user_id"  => current_user.id)
    end
  end
  
  def duplicate
   
  end
  
  def notlogged
    
  end
end