require 'open-uri'
require 'pry'

class Scraper

	def self.scrape_index_page(index_url)
		students = []

		html = open(index_url)
		Nokogiri::HTML(html).css(".roster-cards-container .student-card").each {|student|
			students.push({
				:name => student.css("h4").text,
				:location => student.css("p.student-location").text,
				:profile_url => student.css("a").attr("href").text
			})
		}
		students
	end

	def self.scrape_profile_page(profile_url)
		profile = {}
		html = open(profile_url)
		info = Nokogiri::HTML(html)
		# binding.pry 
		info.css(".vitals-container a").each {|social|
			link = social.attr("href")
			if link.include?("twitter")
				profile[:twitter] = link
			elsif link.include?("linkedin")
				profile[:linkedin] = link
			elsif link.include?("github")
				profile[:github] = link
			else
				profile[:blog] = link
			end
		}
		profile[:profile_quote] = info.css(".vitals-container .profile-quote").text
		profile[:bio] = info.css(".details-container .description-holder p").text
		profile
	end
end

