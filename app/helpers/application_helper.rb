module ApplicationHelper
  def page_title(tit = "")
    base = t "base"

    if tit.empty?
      base
    else
      tit + " | " + base
    end
  end

  def flash_message_type message_type
    case message_type
    when "success"
      message_alert_type = "success";
    when "user_not_found"
      message_alert_type = "danger";
    when "invalid_login"
      message_alert_type = "danger";
    when "not_logged_in"
      message_alert_type = "danger";
    when "can_not_delete_user"
      message_alert_type = "danger";
    when "info"
      message_alert_type = "info";
    else
      message_alert_type = "danger"
    end
  end
end
