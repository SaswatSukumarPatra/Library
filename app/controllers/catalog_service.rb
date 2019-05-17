module CatalogService
  @@book = { 'book1' => 'Booking', 'book2' => 'booker' }

  def book
    @@book
  end

  def self.signup
    print 'hello'
  end
  # def self.name_search(bookname)
  #   @@book.select do |k, _|
  #     k.to_s.casecmp(bookname) == 1
  #   end
  # end
end
