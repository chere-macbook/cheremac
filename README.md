# Coding Chalanges


## Class to fetch github user details and claculate score on the basis of commit

The Code is a sample code to calculate points/score of github user on the commit's performed by him in github

```
score_for_each_commit = {
  'IssuesEvent' => 7,
  'IssueCommentEvent' => 6,
  'PushEvent' => 5,
  'PullRequestReviewCommentEvent' => 4,
  'WatchEvent' => 3,
  'CreateEvent' => 2
}

```
Above hash defines points/score for each event performed by the github user

```
github_username = 'dhh'
user = UserScore.new(github_username, score_for_each_commit)
```

Above is the sample to calculate score
