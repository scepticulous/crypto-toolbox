require 'aes'
require 'openssl'
require 'forwardable'

require 'crypto-toolbox/crypt_buffer/concerns/arithmetic.rb'
require 'crypto-toolbox/crypt_buffer/concerns/byte_expander.rb'
require 'crypto-toolbox/crypt_buffer/concerns/comparable.rb'
require 'crypto-toolbox/crypt_buffer/concerns/convertable.rb'
require 'crypto-toolbox/crypt_buffer/concerns/padding.rb'
require 'crypto-toolbox/crypt_buffer/concerns/pretty_print.rb'
require 'crypto-toolbox/crypt_buffer/concerns/random.rb'
require 'crypto-toolbox/crypt_buffer/concerns/xor.rb'

class CryptBuffer
  class OutOfRangeError < RuntimeError; end
  
  include CryptBufferConcern::Arithmetic
  include CryptBufferConcern::ByteExpander
  include CryptBufferConcern::Convertable
  include CryptBufferConcern::Comparable
  include CryptBufferConcern::Padding
  include CryptBufferConcern::PrettyPrint
  include CryptBufferConcern::Random
  include CryptBufferConcern::Xor

  
  include Enumerable
  extend Forwardable
  def_delegators :@bytes, :[], :empty?,:include?, :each, :length

  
  attr_accessor :bytes
  alias_method :b, :bytes

  
  def initialize(byte_array)
    @bytes = byte_array
  end

  # Make sure input strings are always interpreted as hex strings
  # This is especially useful for unknown or uncertain inputs like
  # strings with or without leading 0x
  def self.from_hex(input)
    CryptBufferInputConverter.new.from_hex(input)
  end

  # Returns an array of the nth least sigificant by bit of each byte
  def nth_bits(n)
    raise OutOfRangeError if n < 0
    raise OutOfRangeError if n > 7
    
    bits.map{|b| b.reverse[n].to_i }
  end
  
  def chunks_of(n)
    self.bytes.each_slice(n).map{|chunk| CryptBuffer(chunk) }
  end
  
  private
  def xor_multiple(byte,bytes)
    ([byte] + bytes).reduce(:^)
  end
end


