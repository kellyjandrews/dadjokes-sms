workflow "Deploy to Heroku" {
  on = "push"
  resolves = ["Release App"]
}

action "Login to Heroku" {
  uses = "actions/heroku@master"
  args = "container:login"
  secrets = ["HEROKU_API_KEY"]
}

action "Push Container" {
  uses = "actions/heroku@466fea5e8253586a6df75b10e95447b0bfe383c1"
  needs = ["Login to Heroku"]
  args = "[\"container:push\", \"web\", \"-a dadjokes-sms\"]"
  secrets = ["HEROKU_API_KEY"]
}

action "Release App" {
  uses = "actions/heroku@466fea5e8253586a6df75b10e95447b0bfe383c1"
  needs = ["Push Container"]
  secrets = ["HEROKU_API_KEY"]
  args = "[\"container:release\", \"web\", \"-a dadjokes-sms\"]"
}
