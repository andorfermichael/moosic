# moosic

`moosic` combines both YouTube and SoundCloud in one web application. Login with one of four social platforms or 
just use an email and a password. Search tracks in the databases of both YouTube and SoundCloud. Create playlists by yourself
or fork other peoples playlists. Finally listen to those amazing playlists and don't be concerned if a song is located on YouTube
or SoundCloud. Moosic handles everything for you!  
  
`moosic` has been developed during the lecture "Multimedia Project 2" at 
[Salzburg University of Applied Sciences](http://www.fh-salzburg.ac.at/en/), 
[MultiMediaTechnology Bachelor Degree](http://www.fh-salzburg.ac.at/en/disciplines/design-media-arts/bachelor-multimediatechnology/degree-programme/degree-programme/).

# Setup

```ruby
bundle install
rake db:migrate
```
Go to directory config, rename application-sample.yml to application.yml and add your secrets.

# Usage

```ruby
rails server
```

# Test

```
rspec
```

# Authors

- [Michael Andorfer](mailto:mandorfer.mmt-b2014@fh-salzburg.ac.at)
- [Bernhard Steger](mailto:bsteger.mmt-b2013@fh-salzburg.ac.at)

# License

[The MIT License](https://opensource.org/licenses/MIT)
