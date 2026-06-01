class BoardPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.accessible_to(user)
    end
  end

  def index?
    true
  end

  def show?
    assigned_workspace?
  end

  def create?
    assigned_workspace? && project_in_workspace?
  end

  def new?
    true
  end

  def edit?
    owns_workspace?
  end

  def update?
    edit? && project_in_workspace?
  end

  private

  def assigned_workspace?
    return false if record.workspace_id.blank?

    Workspace.accessible_to(user).exists?(id: record.workspace_id)
  end

  def owns_workspace?
    return false if record.workspace.blank?

    record.workspace.owner_id == user.id
  end

  def project_in_workspace?
    return false if record.project_id.blank?

    Project.accessible_to(user).exists?(id: record.project_id, workspace_id: record.workspace_id)
  end
end
