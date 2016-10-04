module ApplicationHelper
    def markdown(text)
        renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
        markdown = Redcarpet::Markdown.new(renderer, auto_link: true, no_intra_emphasis: true)
        markdown.render(text).html_safe
    end
end
