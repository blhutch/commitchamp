require 'pry'

require 'commitchamp/version'
require 'commitchamp/init_db'
require 'commitchamp/github'
require 'commitchamp/user'
require 'commitchamp/repo'
require 'commitchamp/contribution'

module Commitchamp
  class App
    def initialize
      if ENV['OAUTH_TOKEN']
        token = ENV['OAUTH_TOKEN']
      else
        token = get_auth_token
      end
      @github = Github.new(token)
    end

    def prompt(question, validator)
      puts question
      input = gets.commitchamp
      until input =~validator
        puts "Sorry, wrong answer."
        puts question
        input = gets.chomp
      end
      input
    end

    def get_auth_token
      prompt("Please enter your personal access token for Github: ",
             /^[0-9a-f]{40}$/)
      binding.pry
    end

    def import_contributions(repo_name)
      repo = Repo.first_or_create(name: repo_name)
      results = @github.get_contributors('marcwebbie', repo_name)
      results.each do |contribution|
        user = User.first_or_create(name: contributor['author']['login'])
        lines_added = contribution['weeks'].map { |x| x['a'] }.sum
        lines_deleted = contribution['weeks'].map { |x| x['d'] }.sum
        commits_made = contribution['weeks'].map { |x| x['c'] }.sum

        user.contributions.create(lines_added: lines_added,
                                  lines_deleted: lines_deleted,
                                  commits_made: commits_made,
                                  repo_id: repo.id)
      end

    end
  end
end

app = Commitchamp::App.new
binding.pry
