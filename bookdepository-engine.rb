class BookDepositoryEngine < Engine
  attr_reader :base_address, :name

  def initialize(base_address, name)
    @base_address = base_address
    @name = name
  end

  def lookup(isbn)
    doc = open("http://#{@base_address}/search?searchTerm=#{isbn}") { |f| Hpricot(f) }

    path = ['span.price'].find do |path| 
      begin
        (doc/path).first.inner_html
      rescue
      end
    end

    if path != nil
      price = parse_price((doc/path).first.inner_html)
      price.to_f
    else
      0
    end
  end

  def parse_price(raw_price)
    raw_price.gsub(/&#\d+;/, "").scan(/\d+/).join(".").to_f
  end
end
