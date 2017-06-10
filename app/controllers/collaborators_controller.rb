class CollaboratorsController < ApplicationController
    before_action: set_wiki

    def new 
        @collaborator = Collaborator.new
    end
    
    def create 
        @collaborator = Collaborator.new(wiki_id: @wiki_id, user_id: params[:user_id] )

        if @collaborator.save
            flash[:notice] = "New Collaborator was added to the Wiki"
            redirect_to @wiki
        else
            flash[:error] = "Collaborator was not added. Try again!"
            render :show
        end
    end
    
    def destroy 
        @collaborator = Collaborator.find(params[:id])

        if @collaborator.destry 
            flash[:notice] = "Collaborator was removed from Wiki."
            redirect_to @wiki 
        else
            flash[:error] = "Collaborator was not removed. Please try again!"
            render :show
        end
    end

    private 

    def set_wiki 
        @wiki = Wiki.find(params[:wiki_id])
    end
           
end
