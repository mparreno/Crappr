module ApplicationHelper
  def is_mobile?
    request.user_agent =~ /Mobile|webOS/ && !(request.user_agent =~ /iPad/)
  end
end
