class ProjectPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.owner?
        scope.all
      else
        scope.none
      end 
    end
  end
    def index
      user.owner?
    end
    def show?
      user.owner?
    end
    def edit?
      user.owner?
    end
    def update?
      edit?
    end

    def destroy?
      user.owner?
    end

    def create?
      user.owner?
    end
 
    def new?
      create?
    end
end
