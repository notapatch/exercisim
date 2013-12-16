class PhoneNumber
  attr_reader :number
  INVALID_NUMBER = '0000000000'
  DIGITS_IN_LOCAL = 10
  DIGITS_IN_INTERNATIONAL = 11

  def initialize number
    @number = clean_number(number)
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{area_code}) #{prefix}-#{identifier}"
  end

  private

  def clean_number dirty_number
    return INVALID_NUMBER unless valid?(to_digits dirty_number)
    to_digits(dirty_number).chars.last(DIGITS_IN_LOCAL).join
  end

  def valid? number
    local?(number) || international?(number)
  end

  def to_digits number
    number.scan(/\d+/).join
  end

  def local? number
    number.size == DIGITS_IN_LOCAL
  end

  def international? number
    number.size == DIGITS_IN_INTERNATIONAL && number.start_with?('1')
  end

  def prefix
    number[3..5]
  end

  def identifier
    number[6..9]
  end
end