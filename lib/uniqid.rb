# уникальное - время с миллисекундами
module Uniqid
  def self.uniqid(len = 11)
    if len == :max
      "#{Time.now.to_f.to_s.gsub(/\./, '')}#{SecureRandom.hex(20).to_i(16)}"
    else
      uniqid(:max).slice(-len, len)
    end
  end

  def self.id(len = 11)
    uniqid(len)
  end

  # уникальное целое
  def self.uniq_positive(len = 11)
    SecureRandom.random_number(10 ** len - 1) + 1
  end

  def self.positive(len = 11)
    uniq_positive(len)
  end

  # уникальное целое положительное
  def self.uniqp(len = 9)
    uniq_positive(len)
  end

  def self.p(len = 9)
    uniq_positive(len)
  end
end
