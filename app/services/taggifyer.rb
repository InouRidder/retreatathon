class Taggifyer
  attr_reader :object, :stringified_attributes, :query_fields

  def initialize(object)
    @object = object
    @stringified_attributes = ""
    @query_fields = "#{object.class}::SEARCHABLE_ATTR".constantize
    attributes_to_string
  end

  def run
    Tag.all.each do |tag|
      title = tag.title
      if stringified_attributes.match? /\b#{tag.title}\b/
        object.taggings.create(tag: tag)
      end
    end
  end

  private

  def attributes_to_string
    array = []
    stringified_attributes << query_fields.map { |field| object.send(field) }.join(" ")
  end
end
