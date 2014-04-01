class CommitMessage
  attr_accessor :revision, :repo

  def initialize(revision: "HEAD", repo: nil)
    @revision = revision
    @repo = repo || Dir.pwd
  end

  def to_s
    if pull_request
      "Pull Request ##{pull_request}: #{branch}"
    elsif branch
      "#{name}: Merge '#{branch}' into '#{local_branch}'"
    else
      "#{name}: #{message}"
    end
  end

  private

  def name
    raw_message[/^Author: (.+) (?:<.+>)$/, 1]
  end

  def pull_request
    message[/^Merge pull request #(\d+)/, 1]
  end

  def branch
    return unless is_merge?
    message[/from .+\/(.+)$/, 1] or message[/^Merge branch '(.+?)'/, 1]
  end

  def local_branch
    message[/into (.+)$/, 1]
  end

  def message
    raw_message.lines.last.strip
  end

  def git_command
    "git log --pretty=short -1 #{revision}"
  end

  def is_merge?
    raw_message.lines[1].start_with?("Merge: ")
  end

  def raw_message
    Dir.chdir(repo) { `#{git_command}` }.strip
  end
end
