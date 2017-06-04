class WikiPolicy < ApplicationPolicy
    attr_reader :user, :wiki 

    def initialize(user, wiki) 
      @user = user
      @wiki = wiki
    end

  def index?
    false
  end

  def show?
    record.public? || user.present?
  end

  def create?
    show?
  end

  def new?
    show?
  end

  def update?
    user.admin? or user.present?    
  end

  def edit?
    show?
  end

  def destroy?
    user.admin? or user.premium?
  end

  class Scope


    def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all 
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki || wiki.user == user || wiki.collaborated_users.include?(user) 
             wikis << wiki 
           end
         end
       else 
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public? || wiki.collaborated_users.include?(user)
             wikis << wiki 
           end
         end
       end
    all_wikis
     end
   end
end