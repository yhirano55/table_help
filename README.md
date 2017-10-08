# TableHelp

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/table_help.svg)](https://badge.fury.io/rb/table_help)
[![Build Status](https://travis-ci.org/yhirano55/table_help.svg?branch=master)](https://travis-ci.org/yhirano55/table_help)

Provide helper methods to build collection or resource tables for Rails 5.

`table_for` and `attributes_table_for` helper methods implemented in `TableHelp` are inspired by [ActiveAdmin](https://github.com/activeadmin/activeadmin).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'table_help'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install table_help

## Usage

### Collection

```html+erb
<%= table_for @articles do |t| %>
  <% t.column :title %>
  <% t.column :body do |article| %>
    <%= truncate(article.body) %>
  <% end %>
  <% t.column :created_at %>
  <% t.column :updated_at %>
  <% t.column do |article| %>
    <ul>
      <li><%= link_to "Show", article %></li>
      <li><%= link_to "Edit", edit_article_path(article) %></li>
      <li><%= link_to "Destroy", article, method: :delete %></li>
    </ul>
  <% end %>
<% end %>
```

### Resource

```html+erb
<%= attributes_table_for @article do |t| %>
  <% t.row :title %>
  <% t.row :body do |article| %>
    <%= truncate(article.body) %>
  <% end %>
  <% t.row :created_at %>
  <% t.row :updated_at %>
  <% t.row do |article| %>
    <ul>
      <li><%= link_to "Edit", edit_article_path(article) %></li>
      <li><%= link_to "Destroy", article, method: :delete %></li>
    </ul>
  <% end %>
<% end %>
```

## Configuration

You can change the default options for each table.

```ruby
# config/initializers/table_help.rb
TableHelp.config.default_options = {
  table_for: { class: "table_for your_optional_style", border: "1" },
  attributes_table_for: { class: "attributes_table_for your_optional_style", border: "0" },
}
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
