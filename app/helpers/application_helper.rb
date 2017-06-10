module ApplicationHelper
   def form_group_tag(errors, &block)
     if errors.any?
        content_tag :div, capture(&block), class: 'form-group has-error'
     else         
        content_tag :div, capture(&block), class: 'form-group'
    end
   end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      space_after_headers: true,
      fenced_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end   
end
