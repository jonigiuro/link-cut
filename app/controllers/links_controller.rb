class LinksController < ApplicationController

  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end


  def edit
    @link = Link.find(params[:id])
  end
  
  def show
    @link = Link.find(params[:id])
  end
  
  def create
    if Link.where('comp' => params[:full_path]).count != 0
       redirect_to Link.where('comp' => params[:full_path]).first.orig and return 
    end
    
    if Link.where('orig' => params[:full_path]).count != 0
      redirect_to Link.where('orig' => params[:full_path]).first and return
    end
    
    @link = Link.new
    @link.orig = params[:full_path]

    if Link.count == 0
      @link.comp = 0
    else
      @link.comp = (Link.last.id + 1).to_s(36)
    end
    
    
    @link.save
    redirect_to @link, :alert  => "hola"
  end
  
  def hola
    
    if Link.where('comp' => params[:full_path]).count != 0
      redirect_to Link.where('comp'  => params[:full_path]).first.orig and return
    else
      if Link.where('orig' => params[:full_path]).count != 0
        @link = Link.where('orig' => params[:full_path]).first
        @link.total = @link.total + 1
        if user_signed_in?
          @link.user_id = current_user.id
        else
          @link.user_id = 0
        end
        @link.save
      else
        @link=Link.new
        @link.orig = params[:full_path]
        if Link.count == 0
          @link.comp = 0
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
  end
  
  def home
    if user_signed_in?
      @links = Link.where("user_id"  => current_user.id)
    end
  end
end