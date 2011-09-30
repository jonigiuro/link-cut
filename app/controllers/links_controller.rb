class LinksController < ApplicationController

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
    if Link.where('orig'  => params[:full_path]).count != 0
      return false
    else
      @link=Link.new
      @link.orig = params[:full_path]
      if Link.count == 0
        @link.comp = '0'
      else
        @link.comp = (Link.last.id + 1).to_s(36)
      end
    
      if user_signed_in?
        @link.user_id = current_user.id
      else
        @link.user_id = 0
      end
      @link.save
    end
  end
  
  def home
    if user_signed_in?
      @links = Link.where("user_id"  => current_user.id)
    end
  end
end