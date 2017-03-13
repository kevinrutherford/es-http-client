require 'securerandom'

module RandomHelpers

  def random_int
    Random.rand(1000) + 1
  end

  def random_word
    SecureRandom.hex(10)
  end

  def random_id
    UUIDTools::UUID.random_create.to_s
  end

end
