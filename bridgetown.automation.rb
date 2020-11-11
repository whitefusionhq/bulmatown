# Thanks to https://github.com/ParamagicDev for a bunch of the smarts in this
# automation :)

add_bridgetown_plugin "bulmatown"
add_bridgetown_plugin "bridgetown-quick-search"

# 0.15 bug! :( can't use this:
#add_yarn_for_gem "bulmatown"

gem_version = (`bundle info bulmatown`).match(/\*.*\((.*?)\)/)[1]
run "yarn add bulmatown@#{gem_version}"

require 'fileutils'
require 'shellwords'

unless Dir.exist? "frontend/fonts"
  FileUtils.mkdir_p "frontend/fonts"
end

run "cp node_modules/fork-awesome/fonts/* frontend/fonts"

javascript_import 'import Bulmatown from "bulmatown"'

# *** Set up remote repo pull

# Dynamically determined due to having to load from the tempdir
@current_dir = File.expand_path(__dir__)

# If its a remote file, the branch is appended to the end, so go up a level
ROOT_PATH = if __FILE__ =~ %r{\Ahttps?://}
              File.expand_path('../', __dir__)
            else
              File.expand_path(__dir__)
            end

DIR_NAME = File.basename(ROOT_PATH)

# DIR_NAME = 'bulmtatown'
GITHUB_PATH = "https://github.com/arca0/#{DIR_NAME}.git"

# Copied from: https://github.com/mattbrictson/rails-template
# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require 'tmpdir'

    source_paths.unshift(tempdir = Dir.mktmpdir(DIR_NAME + '-'))
    at_exit { FileUtils.remove_entry(tempdir) }
    run("git clone --quiet #{GITHUB_PATH.shellescape} #{tempdir.shellescape}")

    if (branch = __FILE__[%r{#{DIR_NAME}/(.+)/bridgetown.automation.rb}, 1])
      Dir.chdir(tempdir) { system("git checkout #{branch}") }
      @current_dir = File.expand_path(tempdir)
    end
  else
    source_paths.unshift(DIR_NAME)
  end
end

def copy_if_exists(file)
  target = "src/_layouts/#{file}.liquid"
  target = "src/_layouts/#{file}.html" if File.exist?("src/_layouts/#{file}.html")
  copy_file "example/src/_layouts/#{file}.liquid", target
end

def substitute_in_default_if_exists
  if File.exists?("src/_layouts/default.liquid")
    gsub_file "src/_layouts/default.liquid", '{% render "footer", ', '{% render "footer", url: site.url, '
  elsif File.exists?("src/_layouts/default.html")
    gsub_file "src/_layouts/default.html", '{% render "footer", ', '{% render "footer", url: site.url, '
  else
    say_status :bulmatown, "Could not find the default template. You will have to add the url parameter to the render command manually"
  end
end

if yes? "The Bulmatown installer can update styles, layouts, and page templates to use the new theme. You'll have the option to type 'a' to overwrite all existing files or 'd' to inspect each change. Would you like to proceed? (Y/N)"
  add_template_repository_to_source_path

  create_file "frontend/styles/index.scss", '@import "~bulmatown/frontend/styles"'

  ["home", "page", "post"].each { |f| copy_if_exists(f) }
  substitute_in_default_if_exists

  copy_file "example/src/index.md", "src/index.md"
  copy_file "example/src/posts.md", "src/posts.md"
  copy_file "example/src/404.html", "src/404.html"
  
  copy_file "example/src/_components/navbar.liquid", "src/_components/navbar.liquid"
  copy_file "example/src/_components/footer.liquid", "src/_components/footer.liquid"

  inject_into_file "bridgetown.config.yml", "pagination:\n  enabled: true\n", after: "permalink: pretty\n"
end

twitter = ask "Do you have a Twitter handle? If so, enter it here, otherwise type 'no'"

if twitter != "" && twitter != "no"
  append_to_file "src/_data/site_metadata.yml" do
    <<~YAML

      twitter: #{twitter}

    YAML
  end
end

say_status :bulmatown, "Theme installation complete! Enjoy your fresh new design :)"
