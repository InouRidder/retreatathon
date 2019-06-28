require 'csv'
require 'pry'
require 'open-uri'
require 'stopwords'
require 'json'

csv_options = { col_sep: ',', quote_char: '"'}
filepath    = 'products.csv'

@recurrences = Hash.new(0)


def row_to_recurrences(row)
  normalise_text(row).each do |word|
    @recurrences[word] += 1 if word.length > 2
  end
end

def normalise_text(row)
  filter = Stopwords::Snowball::Filter.new "en"
  text = row.join(" ").downcase.gsub(/\W/, " ").gsub(/\d/, "").split(" ")
end

i = 0
CSV.foreach(filepath, csv_options) do |row|
  if i >= 1
    row_to_recurrences(row)
  else
    i += 1
  end
end


def remove_adjectives
  adjectives = open("https://gist.githubusercontent.com/hugsy/8910dc78d208e40de42deb29e62df913/raw/eec99c5597a73f6a9240cab26965a8609fa0f6ea/english-adjectives.txt").read.split(/\n/)
  adjectives.each do |adjective|
    @recurrences.delete(adjective)
  end
end

def remove_filtered_words
  filtered_words = [
    'the', 'and', 'of', 'but', 'yes', 'not', 'no', 'are', 'have', 'often',
     "users", "user", "students", "friends", "help", "through", "out", "based", "create", "Find", "what", "online", "share", "when", "know", "about", "like", "web", "them", "way", "need", "one", "don't", "make", "more", "get", "they", "will", "where", "not", "but", "app", "platform", "find", "The", "from", "want", "can", "have", "people", "are", "who", "their", "you", "your", "with", "for", "the", "and", "go", "be", "has", "there", "des", "made", "being", "during", "together", 'attempting', 'context', 'www', 'com', 'https', 'someone', 'une', 'one'
  ]
  filtered_words.each do |word|
    @recurrences.delete(word)
  end

end

remove_adjectives
remove_filtered_words

tags = @recurrences.sort_by { |word, count| -count }.take(4000)


csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
filepath    = 'tags.csv'

CSV.open(filepath, 'wb', csv_options) do |csv|
  tags.each do |tag|
    p tag[0]
    response = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{tag[0]}").read)
    if response['found']
      csv << [tag]
    end
  end
end

