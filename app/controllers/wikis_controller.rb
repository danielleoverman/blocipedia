class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wiki = policy_scope(Wiki)
  end

  def show
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

  def new
     @wiki = Wiki.new
     if @wiki.private && current_user.standard?
       flash[:alert] = "You must be a priemium user to view this Wiki."
       redirect_to root_path
     end 
  end

  def edit 
    @wiki = Wiki.find(params[:id])
    @wiki.user = current_user
  end
  
  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    @user = current_user

     if @wiki.save
       flash[:notice] = "Wiki was successfully saved."
       redirect_to wikis_path
     else
       flash[:error] = "Error, wiki was not saved! Please try again."
       render :new
     end

  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
    redirect_to wikis_path
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = (params[:wiki][:title])
    @wiki.body =  (params[:wiki][:body])
    authorize @wiki 

    if @wiki.save
      flash[:notice] = "Wiki was successfully updated!"
        redirect_to wikis_path
    else 
       flash[:error] = "Error, wiki was not updated! Please try again."
       render :edit      
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You have to be signed in first."
    redirect_to (request.referrer || root_path )
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user)
   end
 end