module ApplicationHelper
  def markdown(text)
    render_options = {
        hard_wrap: true
    }
    markdown_options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(Redcarpet::Render::SmartyHTML.new(render_options), markdown_options).render(text).html_safe
  end
end