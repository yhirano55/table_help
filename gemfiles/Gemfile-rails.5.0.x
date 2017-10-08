source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

gem "onkcop", require: false
gem "pry"
gem "rails", "~> 5.0"
gem "sqlite3"

group :test do
  gem "capybara"
  gem "rspec", "~> 3.0"
end
