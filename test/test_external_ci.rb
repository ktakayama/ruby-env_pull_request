require_relative 'helper'

module EnvPullRequest
  class TestExternalCi < Test::Unit::TestCase
    extend TestHelper

    def self.startup
      stash_env_pull_request
    end

    def self.shutdown
      restore_env_pull_request
    end

    sub_test_case 'travis-ci' do
      sub_test_case 'pull request' do
        pull_id = 800
        setup do
          ENV['TRAVIS_PULL_REQUEST'] = pull_id.to_s
        end

        teardown do
          ENV.delete 'TRAVIS_PULL_REQUEST'
        end

        test '#pull_request?' do
          assert do
            EnvPullRequest.new.pull_request? == true
          end
        end
        test '#pull_request_id' do
          assert do
            EnvPullRequest.new.pull_request_id == pull_id
          end
        end
      end

      sub_test_case 'not pull request' do
        setup do
          ENV['TRAVIS_PULL_REQUEST'] = 'false'
        end

        teardown do
          ENV.delete 'TRAVIS_PULL_REQUEST'
        end

        test '#pull_request?' do
          assert do
            EnvPullRequest.new.pull_request? == false
          end
        end
        test '#pull_request_id' do
          assert do
            EnvPullRequest.new.pull_request_id.nil?
          end
        end
      end
    end

    sub_test_case 'circle ci' do
      pull_id = 800
      setup do
        ENV['CIRCLE_PR_NUMBER'] = pull_id.to_s
      end

      teardown do
        ENV.delete 'CIRCLE_PR_NUMBER'
      end

      test '#pull_request?' do
        assert do
          EnvPullRequest.new.pull_request? == true
        end
      end
      test '#pull_request_id' do
        assert do
          EnvPullRequest.new.pull_request_id == pull_id
        end
      end
    end

    sub_test_case 'bitrise' do
      pull_id = 800
      setup do
        ENV['BITRISE_PULL_REQUEST'] = pull_id.to_s
      end

      teardown do
        ENV.delete 'BITRISE_PULL_REQUEST'
      end

      test '#pull_request?' do
        assert do
          EnvPullRequest.new.pull_request? == true
        end
      end
      test '#pull_request_id' do
        assert do
          EnvPullRequest.new.pull_request_id == pull_id
        end
      end
    end

    sub_test_case 'Jenkins GitHub pull request builder plugin' do
      pull_id = 800
      setup do
        ENV['ghprbPullId'] = pull_id.to_s
      end

      teardown do
        ENV.delete 'ghprbPullId'
      end

      test '#pull_request?' do
        assert do
          EnvPullRequest.new.pull_request? == true
        end
      end
      test '#pull_request_id' do
        assert do
          EnvPullRequest.new.pull_request_id == pull_id
        end
      end
    end
  end
end
