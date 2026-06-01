class WorkspacePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.accessible_to(user)
    end
  end
    def index?
      true
    end
    def show?
      assigned?
    end
    def edit?
      owns_workspace?
    end
    def update?
      edit?
    end

    def destroy?
      owns_workspace?
    end

    def create?
      user.owner? || user.admin?
    end
 
    def new?
      create?
    end

    private

    def assigned?
      owns_workspace? || record.memberships.exists?(user_id: user.id)
    end

    def owns_workspace?
      record.owner_id == user.id
    end
end
