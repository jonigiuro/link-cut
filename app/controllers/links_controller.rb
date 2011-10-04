class LinksController < ApplicationController

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  
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
  
  def destroy
    Link.find(params[:id]).destroy
    redirect_to :root
  end
  def redir
    if Link.where('comp'  => params[:full_path]).count == 0
      render :action  => "non_existing"
      return false
    else
      redirect_to Link.where('comp'  => params[:full_path]).first.orig and return
    end
  end
  
  def hola
    if user_signed_in?
      if Link.where('orig' => params[:full_path], 'user_id'  => current_user.id).count != 0
        render :action => "duplicate"
        return false
      else
        @link=Link.new
        @link.orig = params[:full_path]
        url = params[:full_path]
        doc = Nokogiri::HTML(open(url))
        @link.title=doc.at_css("title").text
        #@link.title="test"
        if Link.count == 0
          @link.comp = '0'
        else
          @link.comp = (Link.last.id + 1).to_s(36)
        end
        @link.user_id = current_user.id
        @link.save
        end
      else
        render :action => "notlogged"
    end
  end
  
  def home
    if user_signed_in?
      @links = Link.where("user_id"  => current_user.id)
      @links.sort! { |a,b| b.created_at <=> a.created_at }
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def duplicate
   
  end
  
  def notlogged
    
  end
  
  def non_existing
    
  end
  
end