class WikiPolicy <ApplicationPolicy
  
  def index?
    user.present? 
  end
  
  def edit?
    if record.user == user
      true
    else
      false
    end
  end


  def show?
    if @record.private
      if @user.admin? || @user.premium? || @record.user == @user 
        return true
      else
        return false
      end
    else
      return true
    end
  end


  def destroy?
    if @user.admin? || @record.user == @user
      return true
    else
      return false
    end
  end

   class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.owner == user || wiki.collaborators.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end
 end