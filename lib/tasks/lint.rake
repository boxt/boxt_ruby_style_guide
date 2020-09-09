# frozen_string_literal: true

require "boxt_ruby_style_guide"
require "rubocop"

namespace :lint do
  desc "Runs rubocop against all .rb files git lists as changed. Will run
  against all files if none changed"
  task :rubocop do
    run_cmd("rubocop")
  end
end

def run_cmd(cmd)
  xargs = "xargs #{cmd}"
  exec("git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | #{xargs}")
end
