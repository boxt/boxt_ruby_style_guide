# frozen_string_literal: true

require "spec_helper"
require "boxt_ruby_style_guide/git_diff"

RSpec.describe BoxtRubyStyleGuide::GitDiff do
  let(:current_repo_path) { repo_path(repo_name) }
  let(:repo_name) { "test-#{rand(1_000).to_i}" }

  let!(:git) do
    setup_test_repo
    Git.open(current_repo_path).tap do |git_obj|
      git_obj.config("user.name", "Test Git Person") if git_obj.config("user.name").blank?
      git_obj.config("user.email", "email@email.com") if git_obj.config("user.email").blank?
      git_obj.add("README.md")
      git_obj.commit("Save README.md")
      git_obj.branch("feature/new-branch").checkout
    end
  end

  after do
    FileUtils.rm_rf(BoxtRubyStyleGuide.root.join("tmp", "git"))
  end

  describe "#all" do
    subject { described_class.new(*test_filepaths).all }

    context "when file is state U (modified not committed)" do
      before do
        update_file(current_repo_path, "README.md", <<~MARKDOWN)
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        MARKDOWN
      end

      it "is included in the results" do
        Dir.chdir(current_repo_path) do
          expect(described_class.new.all).to include("README.md")
        end
      end
    end

    context "when file is state M (modified and committed)" do
      before do
        update_file(current_repo_path, "README.md", <<~MARKDOWN)
          Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        MARKDOWN
        git.add(current_repo_path.join("README.md").to_s)
        git.commit("Updated README.md")
      end

      it "is included in the results" do
        Dir.chdir(current_repo_path) do
          expect(described_class.new.all).to include("README.md")
        end
      end
    end

    context "when file is state A (staged for commit)" do
      before do
        create_file(current_repo_path, "test_file.rb", <<~RUBY)
          class GitTest
          end
        RUBY
        git.add(current_repo_path.join("test_file.rb").to_s)
      end

      it "is included in the results" do
        Dir.chdir(current_repo_path) do
          expect(described_class.new.all).to include("test_file.rb")
        end
      end
    end

    context "when file is state R (renamed in repo)" do
      before do
        FileUtils.mv(current_repo_path.join("README.md"), current_repo_path.join("README-new.md"))
        git.add(current_repo_path.join("README-new.md").to_s)
        git.remove(current_repo_path.join("README.md").to_s)
        git.commit("Renamed README.md")
      end

      it "is not included in the results" do
        Dir.chdir(current_repo_path) do
          expect(described_class.new.all).not_to include("README-new.md")
        end
      end
    end

    context "when file is state C (copied in repo)" do
      before do
        FileUtils.cp(current_repo_path.join("README.md"),
                     current_repo_path.join("README-new.md"))
        git.add(current_repo_path.join("README-new.md").to_s)
        git.commit("Copied README.md")
      end

      it "is not included in the results" do
        # TODO: Work out how to test this.
        skip "Unsure how to set this up for testing"
        Dir.chdir(current_repo_path) do
          expect(described_class.new.all).not_to include("README-new.md")
        end
      end
    end

    context "when file is state D (deleted from repo)" do
      before do
        git.remove(current_repo_path.join("README.md").to_s)
        git.commit("Deleted README.md")
      end

      it "is not included in the results" do
        Dir.chdir(current_repo_path) do
          expect(described_class.new.all).not_to include("README.md")
        end
      end
    end
  end

  private

  def create_file(repo_path, file_name, content = "")
    File.open(repo_path.join(file_name), "wb") { |f| f.write(content) }
  end

  alias_method :update_file, :create_file

  def repo_path(repo_name)
    BoxtRubyStyleGuide.root.join("tmp", "git", repo_name)
  end

  def create_readme
    create_file(current_repo_path, "README.md", <<~MARKDOWN)
      # Header

      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunts
    MARKDOWN
  end

  def setup_test_repo
    FileUtils.mkdir_p(current_repo_path)
    Git.init(current_repo_path.to_s)
    create_readme
  end
end
