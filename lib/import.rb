# доп методы работы с ActiveRecord
module Import

  # фикс ошибки первичного ключа
  def self.call
    # xml = Nokogiri::XML(open("#{Rails.root}/spec/fixtures/dic.xml"))
    xml = Nokogiri::XML(open('/Users/dog/Downloads/dict.opcorpora.xml'))

    Lemma.delete_all
    LemmaText.delete_all
    LemmaForm.delete_all
    LemmaGrammeme.delete_all

    grammemes = xml.xpath('//dictionary//grammemes/grammeme').map do |xml_grammeme|
      Grammeme.new name: xml_grammeme.css('name').text,
                   alias: xml_grammeme.css('alias').text,
                   description: xml_grammeme.css('description').text,
                   parent: xml_grammeme['parent']
    end
    Grammeme.import grammemes, on_duplicate_key_ignore: true

    # todo: restrictions

    xml.xpath('//dictionary//lemmata/lemma').each do |xml_lemma|
      lemma = Lemma.create lemma_id: xml_lemma['id'].to_i, rev: xml_lemma['rev'].to_i
      xml_lemma.xpath('l').each do |xl|
        lemma_text = LemmaText.create lemma: lemma, text: xl['t']
        LemmaGrammeme.import xl.xpath('g').map { |xg| add_grammeme(lemma_text, xg) }
      end

      xml_lemma.xpath('f').each do |xf|
        lemma_form = LemmaForm.create lemma: lemma, text: xf['t']
        LemmaGrammeme.import xf.xpath('g').map { |xg| add_grammeme(lemma_form, xg) }
      end
    end
  end

  private

  # todo: вставлять не v, а ссылки на grammeme => смена схемы таблицыъ
  def self.add_grammeme(lemma_text, xg)
    LemmaGrammeme.new kind_type: lemma_text.class.name,
                      kind_id: lemma_text.id,
                      grammeme_id: Grammeme.find_by(name: xg['v'])&.id
  end
end
