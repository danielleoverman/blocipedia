class WikisController < ApplicationController
   before_action :authenticate_user!

  def index
     @wiki = Wiki.all 
  end

  def show
     @wiki = Wiki.find(params[:id])
  end

  def new
     @wiki = Wiki.new
  end

  def edit 
    @wiki = Wiki.find(params[:id])
    @wiki.user = current_user
  end
  
  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    @wiki.user = current_user

     if @wiki.save
       flash[:notice] = "Wiki was successfully saved."
       redirect_to wikis_path
     else
       flash[:error] = "Error, wiki was not saved! Please try again."
       render :new
     end

  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body] 
    authorize @wiki 

    if @wiki.save
       flash[:notice] = "Wiki was successfully updated!"
        redirect_to wikis_path
     else
       flash[:error] = "Error, wiki was not updated! Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" has been deleted."
       redirect_to wikis_path
     else
       flash[:error] = "Error, wiki was not deleted! Please try again."
       render :show
     end
   end

  private

  def user_not_authorized
    flash[:alert] = "You have to be signed in first."
    redirect_to (request.referrer || root_path )
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body)
   end
 end