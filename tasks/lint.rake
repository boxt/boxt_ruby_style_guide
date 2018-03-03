# frozen_string_literal: true

require "reek"
require "rubocop"

namespace :lint do
  desc "Runs reek against all .rb files git lists as changed. Will run
  against all files if none changed"
  task :reek do
    run_for("reek")
  end

  desc "Runs rubocop against all .rb files git lists as changed. Will run
  against all files if none changed"
  task :rubocop do
    run_for("rubocop")
  end
end

def run_for(cmd)
  xargs = "xargs #{cmd}"
  exec("git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | #{xargs}")
end
