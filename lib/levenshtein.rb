# https://it.wikireading.ru/29358
class String
  def levenshtein(other, ins = 2, del = 2, sub = 1)
    # ins, del, sub - взвешенные стоимости.
    return nil if self.nil?
    return nil if other.nil?

    dm = [] # Матрица расстояний.

    # Инициализировать первую строку.
    dm[0] = (0..self.length).collect { |i| i * ins }
    fill = [0] * (self.length - 1)

    # Инициализировать первую колонку.
    for i in 1..other.length
      dm[i] = [i * del, fill.flatten]
    end

    # Заполнить матрицу.
    for i in 1..other.length
      for j in 1..self.length
        # Главное сравнение.
        dm[i][j] = [
          dm[i - 1][j - 1] +
            (self[j - 1] == other[i - 1] ? 0 : sub),
          dm[i][j - 1] * ins,
          dm[i - 1][j] + del
        ].min
      end
    end

    # Последнее значение в матрице и есть
    # расстояние Левенштейна между строками.
    dm[other.length][self.length]
  end
end

s1 = 'ACUGAUGUGA'
s2 = 'AUGGAA'
d1 = s1.levenshtein(s2) # 9
pp "#{__FILE__}, #{__LINE__} | d1=#{d1.inspect}"

s3 = 'Pennsylvania'
s4 = 'pencilvaneya'
d2 = s3.levenshtein(s4) # 7
pp "#{__FILE__}, #{__LINE__} | d2=#{d2.inspect}"

s5 = 'abcd'
s6 = 'abcd'
d3 = s5.levenshtein(s6) # 0
pp "#{__FILE__}, #{__LINE__} | d3=#{d3.inspect}"

pp "#{__FILE__}, #{__LINE__} | 'промбанка'.levenshtein('проебанка')=#{'промбанка'.levenshtein('проебанка').inspect}"
