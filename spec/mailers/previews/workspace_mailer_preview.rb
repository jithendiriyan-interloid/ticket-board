# Preview all emails at http://localhost:3000/rails/mailers/workspace_mailer_mailer
class WorkspaceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/workspace_mailer_mailer/invite_member
  def invite_member
    WorkspaceMailer.invite_member
  end

end
