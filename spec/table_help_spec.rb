require "spec_helper"

RSpec.describe TableHelp, type: :feature do
  before do
    3.times.each do |i|
      Article.create(title: "My Awesome Title #{i}", body: ("abc#{i}" * 30))
    end
  end

  describe "#table_for" do
    subject { page.body }

    it "display table" do
      visit "/articles"
      Article.all.find_each do |article|
        within("tr.table-row-article#{article.id}") do
          is_expected.to have_css "td.col-title",      text: article.title
          is_expected.to have_css "td.col-body",       text: article.body.truncate(26)
          is_expected.to have_css "td.col-created_at", text: I18n.l(article.created_at)
          is_expected.to have_css "td.col-updated_at", text: I18n.l(article.updated_at)
          is_expected.to have_link "Show", href: "/articles/#{article.id}"
          is_expected.to have_link "Edit", href: "/articles/#{article.id}/edit"
        end
      end
    end
  end

  describe "#attributes_table_for" do
    let(:article) { Article.all.sample }
    subject { page.body }

    it "display table" do
      visit "/articles/#{article.id}"
      is_expected.to have_css "td.col-title",      text: article.title
      is_expected.to have_css "td.col-body",       text: article.body.truncate(26)
      is_expected.to have_css "td.col-created_at", text: I18n.l(article.created_at)
      is_expected.to have_css "td.col-updated_at", text: I18n.l(article.updated_at)
      is_expected.to have_link "Edit", href: "/articles/#{article.id}/edit"
    end
  end
end
