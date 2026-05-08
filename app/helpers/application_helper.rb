module ApplicationHelper
  def hide_navbar?
    ![ "sessions", "registrations", "passwords", "confirmations", "unlocks" ].include?(controller_name)
  end
end
