add_bridgetown_plugin "bulmatown"
add_bridgetown_plugin "bridgetown-quick-search"
add_yarn_for_gem "bulmatown"

require 'fileutils'

unless Dir.exist? "frontend/fonts"
  FileUtils.mkdir_p "frontend/fonts"
end

run "cp node_modules/fork-awesome/fonts/* frontend/fonts"