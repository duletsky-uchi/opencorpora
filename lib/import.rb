# доп методы работы с ActiveRecord
module Import

  # фикс ошибки первичного ключа
  def self.call
    xml = Nokogiri::XML(open("#{Rails.root}/spec/fixtures/dic.xml"))
    xlemma = xml.xpath('//dictionary//lemmata/lemma').first

    Lemma.delete_all
    LemmaText.delete_all
    LemmaForm.delete_all
    LemmaGrammeme.delete_all

    lemma = Lemma.create lemma_id: xlemma['id'].to_i, rev: xlemma['rev'].to_i
    xlemma.xpath('l').each do |xl|
      ltext = LemmaText.create lemma_id: lemma.id, text: xl['t']
      xl.xpath('g').each do |xg|
        lgrammeme = LemmaGrammeme.create grammeme_type: ltext.class.name, grammeme_id: ltext.id, v: xg['v']
      end
    end
  end
end
