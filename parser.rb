require 'nokogiri'
require 'pry'
require 'json'
require 'rest-client'

courses = []
(2..121).each do |page_number|

	string = File.read("1031/#{page_number}.html")

	document = Nokogiri::HTML(string.to_s)

	table =  document.css('html table#ctl00_ContentPlaceHolder1_Course_GridView tr:nth-child(n+2)').each do |row|
		
		datas = row.css('td')
		#count = 10
		courses << {
			serial_No: datas[0] && datas[0].text.strip,
			curriculum_No: datas[1] && datas[1].text.strip,
			name: datas[2] && datas[2].text.strip.gsub(/\s+/, ' '),
			name_href: datas[2] && datas[2].css('a')[0] && datas[2].css('a')[0][:href],
			class_id: datas[3] && datas[3].text.strip,
			team: datas[4] && datas[4].text.strip,
			required: datas[5] && datas[5].text.strip.gsub(/\s+/, ' '),
			credit: datas[6] && datas[6].text.strip,
			schedule: datas[7] && datas[7].text.strip,
			lecturer: datas[8] && datas[8].text.strip,
			class_member: datas[9] && datas[9].text.strip,
			note: datas[11] && datas[11].text.strip.gsub(/\s+/, ' '),
		}

	end

end
File.open('courses.json','w'){|file| file.write(JSON.pretty_generate(courses))}
