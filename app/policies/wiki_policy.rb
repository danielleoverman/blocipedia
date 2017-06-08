class WikiPolicy <ApplicationPolicy
  
  def edit?
    if record.user == user
      true
    else
      false
    end
  end


  def show?
    if @record.private
      if @user.admin? || @user.premium? || @record.user == @user || @user.collaborators
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
           wikis = scope.all
         elsif user.role == 'premium'
       all_wikis = scope.all
       all_wikis.each do |wiki|
         if !wiki.private? || wiki.owner == user || wiki.collaborating_users.include?(user)
           wikis << wiki
         end
       end
     else
       all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.collaborating_users.include?(user)
             wikis << wiki
           end
       end
     end
     wikis
   end
 end
end