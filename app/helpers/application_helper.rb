module ApplicationHelper
  def page_title(tit = "")
    base = "Rails sample application"

    if tit.empty?
      base
    else
      tit + " | " + base
    end
  end
end
