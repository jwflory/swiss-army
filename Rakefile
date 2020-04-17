abort("Please run this using `bundle exec rake`") unless ENV["BUNDLE_BIN_PATH"]
require "html-proofer"

desc "Generate HTML documentation and test with html-proofer."
task :test do
  options = {
    :check_html => true,
    :http_status_ignore => [0,999],
    :cache => {
      :timeframe => "6w"
    }
  }
  HTMLProofer.check_directory("./docs/_build/", options).run
end

task :default => [:test]
