add_bridgetown_plugin "bulmatown"
add_bridgetown_plugin "bridgetown-quick-search"
add_yarn_for_gem "bulmatown"

require 'fileutils'

unless Dir.exist? "frontend/fonts"
  FileUtils.mkdir_p "frontend/fonts"
end

run "cp node_modules/fork-awesome/fonts/* frontend/fonts"

javascript_import 'import Bulmatown from "bulmatown"'

if ask "The Bulmatown theme can update layout and page templates in your site to use the theme. Would you like to continue?"
  layout_tmpl = ->(tmpl_name) do
    <<~HTML
      ---
      layout: bulmatown/#{tmpl_name}
      ---
      
      {{ content }}
    HTML
  end
  create_file "src/_layouts/home.html", layout_tmpl(:home)
  create_file "src/_layouts/page.html", layout_tmpl(:page)
  create_file "src/_layouts/post.html", layout_tmpl(:post)

end
