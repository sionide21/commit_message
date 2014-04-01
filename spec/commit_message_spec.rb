require 'commit_message'

describe CommitMessage do
  let (:commit_message) { CommitMessage.new }

  describe '.new' do
    it "defaults to HEAD in the CWD" do
      expect(commit_message.revision).to eq("HEAD")
      expect(commit_message.repo).to eq(Dir.pwd)
    end

    it "accepts parameters" do
      commit_message = CommitMessage.new(revision: "master", repo: "/path/to/repo")
      expect(commit_message.revision).to eq("master")
      expect(commit_message.repo).to eq("/path/to/repo")
    end
  end

  describe '#to_s' do
    it "falls back to the author and message" do
      commit_message.stub(:raw_message) { "commit 06082f66d541e581110406bbac3bc395bace3f86\nAuthor: Ben Olive <ben.olive@example.com>\n\n    Fire ze missiles" }
      expect(commit_message.to_s).to eq("Ben Olive: Fire ze missiles")
    end

    it "leaves reverts alone" do
      commit_message.stub(:raw_message) { "commit 4184d2d2b06eaa81a5a48678956dfd28feb6b118\nAuthor: Ben Olive <ben.olive@example.com>\n\n    Revert \"Merge pull request #95 from SalesLoft/super-secret-project\"" }
      expect(commit_message.to_s).to eq("Ben Olive: Revert \"Merge pull request #95 from SalesLoft/super-secret-project\"")
    end

    it "renders the pull request" do
      commit_message.stub(:raw_message) { "commit fc0b98da0b83329474922a920a6070d370091228\nMerge: f54dd28 4d344bb\nAuthor: Ben Olive <ben.olive@example.com>\n\n    Merge pull request #314 from SalesLoft/super-secret-project" }
      expect(commit_message.to_s).to eq("Pull Request #314: super-secret-project")
    end

    it "renders pulls" do
      commit_message.stub(:raw_message) { "commit 8ff2e3ac2bf32b3c05584e08ab977306d84bc02d\nMerge: d51e937 50464d8\nAuthor: Ben Olive <ben.olive@example.com>\n\n    Merge branch 'pirates' of github.com:SalesLoft/repo into master" }
      expect(commit_message.to_s).to eq("Ben Olive: Merge 'pirates' into 'master'")
    end

    it "renders merges" do
      commit_message.stub(:raw_message) { "commit a8ab66d0bdd40a4612425b0a0fee1417fbfbf940\nMerge: 617b40c 4184d2d\nAuthor: Ben Olive <ben.olive@example.com>\n\n    Merge branch 'master' into test" }
      expect(commit_message.to_s).to eq("Ben Olive: Merge 'master' into 'test'")
    end
  end

  describe '#git_command' do
    it "returns the expected git command" do
      expect(commit_message.send(:git_command)).to eq("git log --pretty=short -1 HEAD")
    end
  end
end
