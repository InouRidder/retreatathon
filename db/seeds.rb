require 'csv'

CSV.foreach(Rails.root.join('db/tags.csv')) do |row|
  Tag.create(title: row[0])
end

CSV.foreach(Rails.root.join('db/products.csv'), headers: true, header_converters: :symbol) do |row|
  product = Product.find_or_create_by(name: row[:name]) do |product|
    product.name = row[:name]
    product.host = row[:host]
    product.tagline = row[:tagline]
    product.github_repository_url = row[:github_repository_url]
    product.user_core_journey = row[:user_core_journey]
    product.originality = row[:originality]
    product.pain = row[:pain]
    product.solution = row[:solution]
    product.customer_segment = row[:customer_segment]
    product.batch = "#{row[:city]}#row#{[:slug]}"
  end
  product.members.create(first_name: row[:first_name], last_name: row[:last_name])
end

