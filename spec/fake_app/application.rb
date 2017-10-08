require "active_record"
require "action_controller/railtie"
require "action_view/railtie"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

module FakeApp
  class Application < Rails::Application
    config.secret_token = "75633674e59de6a3b28da1c37f0f1479"
    config.session_store :cookie_store, key: "_fake_session"
    config.active_support.deprecation = :log
    config.eager_load = false
    config.action_dispatch.show_exceptions = false
    config.root = File.dirname(__FILE__)
  end
end

FakeApp::Application.initialize!

FakeApp::Application.routes.draw do
  resources :articles
end

class Article < ActiveRecord::Base
end

module ApplicationHelper
end

class ApplicationController < ActionController::Base
  self.append_view_path File.dirname(__FILE__)
end

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
end

class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
