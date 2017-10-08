source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "table_help", path: ".."

gem "onkcop", require: false
gem "pry"
gem "rails", "~> 5.1"
gem "sqlite3"

group :test do
  gem "capybara"
  gem "rspec", "~> 3.0"
end
