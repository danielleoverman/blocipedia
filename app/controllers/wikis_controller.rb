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
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))

     if @wiki.save
       flash[:notice] = "Wiki was successfully saved."
       redirect_to @wiki
     else
       flash[:error] = "Error, wiki was not saved! Please try again."
       render :new
     end

  end

  def update
     @wiki = Wiki.find(params[:id])
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was successfully updated!"
       redirect_to @wiki
     else
       flash[:error] = "Error, wiki was not updated! Please try again."
       render :edit
     end
   end

   def destroy
     @wiki = Wiki.find(params[:id])
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" has been deleted."
       redirect_to wikis_path
     else
       flash[:error] = "Error, wiki was not deleted! Please try again."
       render :show
     end
   end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
   end
 end