require 'capybara'
require 'pry'
require 'nokogiri'

class Crawler
  include Capybara::DSL

  def initialize
    Capybara.current_driver = :selenium
  end

  def crawl
    visit "https://webapp.yuntech.edu.tw/WebNewCAS/Course/QueryCour.aspx"
    first('option[value="1031"]').select_option
    click_on '執行查詢'
    page_count = 1
    begin
      while true
        doc = Nokogiri::HTML(html)
        File.open("1031/#{page_count}.html", 'w') { |f| f.write(html) }
      	# 解析

        sleep 4
        first(:link, '下一頁').click
        page_count = page_count + 1
      end
    rescue NoMethodError => e
      # last page
    end

    binding.pry
    puts "hi"
  end


end

crawler = Crawler.new
crawler.crawl

# binding.pry