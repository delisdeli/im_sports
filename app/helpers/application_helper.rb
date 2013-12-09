module ApplicationHelper
  def message_bar_helper(msg, index)
    return case msg.type
      when "Notification" then link_to "#{index+1}: The schedule for your team #{msg.team.name} has changed.", [msg.game.division.league, msg.game.division, msg.game]
      when "Invitation" then link_to "#{index+1}: You have been invited to join team #{msg.team.name}.", current_user
    end
  end
end
