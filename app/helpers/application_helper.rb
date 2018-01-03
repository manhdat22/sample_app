module ApplicationHelper
  def page_title(tit = "")
    base = t "base"

    if tit.empty?
      base
    else
      tit + " | " + base
    end
  end
end
