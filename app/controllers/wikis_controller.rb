class WikisController < ApplicationController
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
  end
 
  def create
    @wiki = Wiki.new(wiki_params)

    @wiki.user = current_user

     if @wiki.save
       flash[:notice] = "Wiki was successfully saved."
       redirect_to wiki_path
     else
       flash[:error] = "Error, wiki was not saved!"
     end

  end

  def update
     @wiki = Wiki.find(params[:id])
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Updated the wiki."
       redirect_to wikis_path
     else
       flash[:error] = "Could not update wiki. Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" has been deleted."
       redirect_to wikis_path
     else
       flash[:error] = "Could not delete the wiki."
       render :show
     end
   end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
   end
 
 end