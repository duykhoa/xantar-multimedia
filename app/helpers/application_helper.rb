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
end
