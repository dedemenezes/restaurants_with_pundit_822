class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    admin?``
  end

  def create?
    admin?
  end

  def edit?
    # get the user and check if the user is the restaurant owner
    # @restaurant.user == current_user
    owner_or_admin?
  end

  def update?
    # Hyphotetical Scenario
    # user.role == "admin" || (user.role == "business_employee")


    #############################
    ##### REAL DEAL #############
    #############################
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    # user which is the current_user from devise
    # record which is the instance that we send in the authorize method in the controller
    @record.user == @user || admin? # read it as @restaurant.user == current_user || current_user.admin == true
  end

  def admin?
    @user.admin
  end
end
