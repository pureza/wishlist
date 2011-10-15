# -*- coding: utf-8 -*-

require 'rubygems'
require 'json'

class CurrencyConverter

  attr_reader :from, :to, :rate

  def initialize(from, to=:eur)
    @from = from
    @to = to

    open("http://www.google.com/ig/calculator?hl=en&q=1#{from}=?#{to}") do |f|
      result = f.read
      @rate = result.scan(/rhs: \"(\d+(\.\d+)?)/)[0][0].to_f
    end
  end

  def convert(price)
    (price * @rate * 100).to_i / 100.0
  end

  def currency_sym(curr)
    case curr
      when :usd then "usd"
      when :gdb then "gdb"
      when :eur then "eur"
    end
  end
end
