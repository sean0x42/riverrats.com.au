# frozen_string_literal: true

module CoreExtensions
  module Integer
    module RomanNumerals
      def to_roman
        result = ''
        number = self
        roman_mapping.keys.each do |divisor|
          quotient, modulus = number.divmod divisor
          result << roman_mapping[divisor] * quotient
          number = modulus
        end
        result
      end

      private

      def roman_mapping
        {
          1000 => 'M',
          900 => 'CM',
          500 => 'DM',
          400 => 'CD',
          100 => 'C',
          50 => 'L',
          40 => 'XL',
          10 => 'X',
          9 => 'IX',
          5 => 'V',
          4 => 'IV',
          1 => 'I'
        }
      end
    end
  end
end

Integer.include CoreExtensions::Integer::RomanNumerals
