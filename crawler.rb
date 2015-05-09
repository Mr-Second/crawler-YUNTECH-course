require 'capybara'
require 'pry'
require 'nokogiri'

class Crawler
  include Capybara::DSL

  def initialize
    Capybara.current_driver = :selenium
  end

  def crawl
    visit "https://webapp.yuntech.edu.tw/WebNewCAS/Course/QueryCour.aspx?lang=zh-TW"
    first('option[value="1031"]').select_option
    click_on '執行查詢'
    # page_count = 1
    (1..121).each do |page_count|
      find("select[name=\"ctl00$ContentPlaceHolder1$PageControl1$Pages\"] option[value=\"#{page_count}\"]").select_option
      # sleep longer if crawl error
      sleep 2
      File.open("1031/#{page_count}.html", 'w') { |f| f.write(html) }
    end
  end
end

crawler = Crawler.new
crawler.crawl

# binding.pry
