class Triggers::PostRelease
  class ParallelBranches
    def self.call(release)
      new(release).call
    end

    def initialize(release)
      @release = release
      @train = release.train
    end

    def call
      create_tag.then { create_and_merge_pr }
    end

    private

    attr_reader :train, :release
    delegate :release_branch, :working_branch, to: :train
    delegate :logger, to: Rails

    def create_and_merge_pr
      Triggers::PullRequest.create_and_merge!(
        release: release,
        new_pull_request: release.pull_requests.post_release.open.build,
        to_branch_ref: working_branch,
        from_branch_ref: release_branch,
        title: pr_title,
        description: pr_description
      ).then do |value|
        stamp_pr_success
        GitHub::Result.new { value }
      end
    end

    def stamp_pr_success
      pr = release.reload.pull_requests.post_release.first
      release.event_stamp!(reason: :post_release_pr_succeeded, kind: :success, data: {url: pr.url, number: pr.number}) if pr
    end

    def create_tag
      GitHub::Result.new { release.create_release! }
    end

    def pr_title
      "[#{release.release_version}] Post-release merge"
    end

    def pr_description
      <<~TEXT
        The release train #{train.name} with version #{release.release_version} has finished.
        The #{release_branch} branch has to be merged into #{working_branch} branch.
      TEXT
    end
  end
end
