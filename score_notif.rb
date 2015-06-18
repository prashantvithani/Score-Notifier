require 'libnotify'
require 'open-uri'
require 'nokogiri'

@url = "http://static.cricinfo.com/rss/livescores.xml"
@match = ""

def fetch_data
	page = Nokogiri::XML(open(@url))
	data = page.css("description")
	data.each do |i|
		if i.to_s.include?("India")
			@match = i.text
			break
		else
			@match = "No India match today"
		end
	end
end

loop {
	fetch_data()
	if @match.include?("India")
		Libnotify.show(summary: "Score", body: @match, timeout: 2)
	end
	sleep(300)
}
