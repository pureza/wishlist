class AmazonEngine < Engine
  attr_reader :name
  attr_reader :currency_converter

  def initialize(subsidiary, currency_converter)
    @name = subsidiary
    @currency_converter = currency_converter
  end

  def lookup(isbn)
    doc = open("http://#{@name}/s/?field-keywords=#{isbn}") { |f| Hpricot(f) }

    path = ['span.saleprice', 'span.sr_price'].find do |path| 
      begin
        (doc/path).first.inner_html
      rescue
      end
    end

    if path != nil
      price = parse_price((doc/path).first.inner_html)
      currency_converter.convert(price)
    else
      0
    end
  end

  def parse_price(raw_price)
    raw_price.scan(/\d+/).join(".").to_f
  end
end
