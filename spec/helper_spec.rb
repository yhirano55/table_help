require "spec_helper"

RSpec.describe TableHelp::Helper do
  include TableHelp::Helper
  include ActionView::Context
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include Capybara::RSpecMatchers

  describe "#table_for" do
    before do
      Article.create(title: "My Awesome Title", body: "Lorem ipsum dolor sit amet")
    end

    subject do
      table_for articles do |t|
        t.column :title
      end
    end

    context "when passed an ActiveRecord::Relation" do
      let(:articles) { Article.all }

      it "builds an HTML table" do
        is_expected.to have_css "td.col-title", text: "My Awesome Title"
      end
    end

    context "when passed an Enumerable" do
      let(:articles) { Article.all.to_a }

      it "builds an HTML table" do
        is_expected.to have_css "td.col-title", text: "My Awesome Title"
      end
    end

    context "when passed an empty Enumerable" do
      let(:articles) { [] }

      it "does not build an HTML table" do
        is_expected.to be_nil
      end
    end
  end

  describe "#attributes_table_for" do
    let(:article) { Article.new(title: "My Awesome Title") }

    subject do
      attributes_table_for article do |t|
        t.row :title
      end
    end

    it "builds an HTML table" do
      is_expected.to have_css "td.col-title", text: "My Awesome Title"
    end
  end
end
