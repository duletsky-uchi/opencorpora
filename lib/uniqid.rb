# уникальное - время с миллисекундами
def uniqid(len = 11)
  if len == :max
    "#{Time.now.to_f.to_s.gsub(/\./, '')}#{SecureRandom.hex(20).to_i(16)}"
  else
    uniqid(:max).slice(-len, len)
  end
end

# уникальное целое
def uniq_positive(len = 11)
  SecureRandom.random_number(10 ** len - 1) + 1
end

# уникальное целое положительное
def uniqp(len = 9)
  uniq_positive(len)
end
