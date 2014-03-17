module ApplicationHelper
  def cover_picture book
    if book && book.edition_key
      edition_key = book.edition_key.first
      image_url = "http://covers.openlibrary.org/b/olid/#{edition_key}-S.jpg"
      return image_url if exist_image_with_edition_key(edition_key)
    end
    '/not_found.jpeg'
  end

  def exist_image_with_edition_key edition_key
    size = FastImage.size "http://covers.openlibrary.org/b/olid/#{edition_key}-S.jpg"
    size && size[0] > 1 && size[1] > 1
  end

  def cover cover
    cover['medium'] if cover
  end

  def published_place places
    address = []
    if places
      address = places.inject([]) { |address, place| address << place['name'] }
    end

    address.join(', ')
  end

  def subjects subjects
    subjects.map { |subject| subject['name'] }.join(', ') if subjects
  end

  def publishers publishers
    publishers.map { |publisher| publisher['name'] }.join(', ') if publishers
  end
end
