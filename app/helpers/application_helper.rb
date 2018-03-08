module ApplicationHelper
  BASE_TITLE = 'BDAdb: Beaver Dam Analogues'.freeze
  def full_title(page_title = '')
    page_title.empty? ? BASE_TITLE : "#{page_title} | #{BASE_TITLE}"
  end

  def form_errors_for(objects)
    render partial: 'shared/form_errors', locals: { object: objects }
  end
end
