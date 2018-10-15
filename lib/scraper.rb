require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students = Nokogiri::HTML(html)

    xx = []

    students.css(".roster .roster-body-wrapper .roster-cards-container a").each do |x|
      # url x.attribute("href").values
      # name x.css("h4").text
      # location x.css("p").text
      xx << {name: x.css("h4").text,
      location: x.css("p").text,
      profile_url: x.attribute("href").value}
      #binding.pry
    end
    xx
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    xx = {}
    links = profile.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}

      links.each do |x|
        if x.include?("linkedin")
          xx[:linkedin] = x
        elsif x.include?("github")
          xx[:github] = x
        elsif x.include?("twitter")
          xx[:twitter] = x
      else
        xx[:blog] = x
      end
      end

      xx[:profile_quote] = profile.css(".profile-quote").text ? profile.css(".profile-quote").text : nil
      xx[:bio] = profile.css(".description-holder p").text ? profile.css(".description-holder p").text : nil
    # binding.pry
    #    twitter: css(".social-icon-container a")[0].attribute("href").value
    #    github: css(".social-icon-container a")[2].attribute("href").value
    #    blog: css(".social-icon-container a")[3].attribute("href").value
    #    profile_quote: .css(".vitals-text-container .profile-quote").text
    #    bio: .css(".description-holder p").text



    # xx[:twitter] = (profile.css(".social-icon-container a")[0] ? profile.css(".social-icon-container a")[0].attribute("href").value : nil)
    # xx[:linkedin] = (profile.css(".social-icon-container a")[1] ? profile.css(".social-icon-container a")[1].attribute("href").value : nil)
    # xx[:github] = profile.css(".social-icon-container a")[2] ? profile.css(".social-icon-container a")[2].attribute("href").value : nil
    # xx[:blog] = profile.css(".social-icon-container a")[3] ? profile.css(".social-icon-container a")[3].attribute("href").value : nil
    # xx[:profile_quote] = profile.css(".profile-quote").text ? profile.css(".profile-quote").text : nil
    # xx[:bio] = profile.css(".description-holder p").text ? profile.css(".description-holder p").text : nil
  #  profile.css("body").collect do |x|
  #      xx[:twitter] = (x.css(".social-icon-container a")[0] ? x.css(".social-icon-container a")[0].attribute("href").value : "www.twitter.com")
  #      xx[:linkedin] = (x.css(".social-icon-container a")[1] ? x.css(".social-icon-container a")[1].attribute("href").value : "www.linkedin.com")
  #      xx[:github] = x.css(".social-icon-container a")[2] ? x.css(".social-icon-container a")[2].attribute("href").value : "www.github.com"
  #      xx[:blog] = x.css(".social-icon-container a")[3] ? x.css(".social-icon-container a")[3].attribute("href").value : "www.blog.com"
  #      xx[:profile_quote] = x.css(".profile-quote").text ? x.css(".profile-quote").text : nil
  #      xx[:bio] = x.css(".description-holder p").text
  #  end
    xx
  end

end
