require 'nokogiri'
require 'net/http'
require 'sinatra'
require "sinatra/json"


class IthacaDirectoryApp < Sinatra::Base

  def parse_person(html)
    output = []
    html.css('tr').each_with_index do |row, idx|
      output << (idx == 0 ? "*#{row.content}*" : row.css('td').text)
    end
    output
  end

  def directory_uri
    URI.parse('https://www.ithaca.edu/directories/index.php')
  end

  def search_page(name)
    people = []
    page = Net::HTTP.post_form(directory_uri, 'search' => "#{name}")
    doc = Nokogiri::HTML.parse(page.body)
    if doc.css('div#dirSearchResults').empty?
      msg = doc.css('#content > table')[0].css('td')[1].text
      return { success: false, error: msg }
    end
    doc.css('div#dirSearchResults table').each do |table_html|
      people << parse_person(table_html)
    end
    { success: true, people: format_json(people) }
  end

  def search(name)
    result = search_page(name)
    return result[:people] if result[:success]
    { text: result[:error] }
  end

  def format_json(people)
    people_json = []
    people.each do |person|
      people_json << { text: person.join('\n'), color: '#00FF00' }
    end
    if people.count > 0
      { text: "#{people.count} results found.", attachments: people_json }
    else
      { text: 'Error: No Results Found' }
    end
  end

  get '/search' do
    json search(params['text'])
  end

end
