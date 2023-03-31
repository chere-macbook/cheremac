require "net/http"
require "uri"
require 'json'

# Class to fetch github user details and claculate score on the basis of commit
class UserScore
  attr_accessor :username, :url, :score, :score_table

  def initialize(username, score_table)
    @username = username
    @score_table = score_table
    @url = "https://api.github.com/users/#{username}/events/public"
    @score = []
  end

  # Method to calculate and display user total score
  def total_score
    calculate_score
    puts "#{username}'s github score is #{score.sum}"
  end

  private

  # Method to calculate user score as per commits
  def calculate_score
    fetch_and_process_user_data.inject(score) do |score, value|
      score << value.last * score_table.fetch(value.first, 1)
    end
  end

  # Method to fetch user data from github
  def fetch_and_process_user_data
    commits = get_user_commits.map { |commit|  commit['type'] }
    commits.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
  end

  # Method to fetch commits from github
  def get_user_commits
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end

score_for_each_commit = {
  'IssuesEvent' => 7,
  'IssueCommentEvent' => 6,
  'PushEvent' => 5,
  'PullRequestReviewCommentEvent' => 4,
  'WatchEvent' => 3,
  'CreateEvent' => 2
}

user = UserScore.new('dhh', score_for_each_commit)
user.total_score
