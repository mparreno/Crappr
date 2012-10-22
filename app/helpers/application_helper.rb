module ApplicationHelper
  def is_mobile?
    request.user_agent =~ /Mobile|webOS|Android|iPhone/i && !(request.user_agent =~ /iPad/)
  end
end
