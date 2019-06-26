require 'csv'

task import_tags: :environment do
  CSV.foreach(Rails.root.join('db/tags.csv')) do |row|
    Tag.create(title: row[0])
  end
end
