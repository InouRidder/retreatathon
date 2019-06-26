class Taggifyer
  attr_reader :object, :stringified_attributes, :query_fields

  def initialize(object)
    @object = object
    @stringified_attributes = ""
    @query_fields = "#{object.class}::SEARCHABLE_ATTR".constantize
  end

  def run
    Tag.all.each do |tag|
      if stringified_attributes.match? tag.title
        object.taggings.create(tag: tag)
      end
    end
  end

  private

  def attributes_to_string
    stringified_attributes << query_fields.each { |field| object.send(field) }
  end
end
