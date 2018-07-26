require "open-uri"
require "nokogiri"
require_relative "search"

class Scrape
  def initialize(role)
    @role = role
  end

  def call
    html = open("https://www.reed.co.uk/jobs/#{role}-jobs-in-london").read
    # 1. Parse HTML
    doc = Nokogiri::HTML(html, nil, "utf-8")
    # 2. For the first five results
    results = []
    doc.search(".job-result").first(10).each do |element|
      # 3. Create recipe and store it in results
      job_title = element.search('.title').text.strip
      description = element.search('.description').text.strip
      link = element.search('href')
      results << Job.new(job_title: job_title, description: description, link: link)
    end
    return results
  end
end
