class BlogHtml < Redcarpet::Render::HTML
  def codespan(code)
    if code.include? "\n"
      code[0,1] = '' if code[0,1] == "\n"
      "<pre><code>#{code}</code></pre>"
    else
      "<code>#{code}</code>"
    end
  end
end

module ApplicationHelper
  def markdown(text)
    render_options = {
        hard_wrap: true,
        prettify: true,
        with_toc_data: true
    }
    markdown_options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true,
        disable_indented_code_blocks: false
    }
    Redcarpet::Markdown.new(BlogHtml.new(render_options), markdown_options).render(text).html_safe
  end
end