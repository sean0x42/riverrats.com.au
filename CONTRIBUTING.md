# Contributing to riverrats.com.au

Thanks for taking the time to contribute to the River Rats official website! Help is always appreciated.



## Branches

We follow the branching model outlined in the article [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/). If you can't be bothered to read all that, here's the important bits.

There are two main branches:

 1. `master`: The current production version of the website.
 2. `develop`: Where future releases are under construction. Unless you're writing a bug fix you'll likely want to start here.

Then there are three types of supporting branches:

 * `feature-*`: A branch which introduces a new feature. e.g. `feature-player-nicknames`.
 * `release-*`: A branch devoted to polishing up the project for a new release. e.g. `release-1.2.1`. Note that only project maintainers will create this kind of branch.
 * `hotfix-*`: For fixing bugs in production.



## Redis

To run the development server you'll need to have an instance of Redis up and running. Jobs are managed by `sidekiq`, so you'll also need to start `sidekiq`. Once Redis is running you can achieve this with the command (from the root project directory):

```
$ bundle exec sidekiq -C config/sidekiq.yml
```


## Elasticsearch

If you want to use searching functionality you'll also need to install elasticsearch on your machine.
