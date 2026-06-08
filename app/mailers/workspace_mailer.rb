class WorkspaceMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.workspace_mailer.invite_member.subject
  #
  def invite_member(membership)
      @membership = membership
      @workspace = membership.workspace
      @invited_by = membership.membership.owner
      @accept_url = accept_membership_url(token: membership.token)

      mail(
        to: membership.email,
        subject: "You're invited to join #{@workspace.name}"
      )
  end
end
