# доп методы работы с ActiveRecord
module Import

  # фикс ошибки первичного ключа
  def self.call
    xml = Nokogiri::XML(open("#{Rails.root}/spec/fixtures/dic.xml"))
    # xml = Nokogiri::XML(open('/Users/dog/Downloads/dict.opcorpora.xml'))

    Link.delete_all
    LinkType.delete_all
    Restriction.delete_all
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
    @grammemes = Grammeme.import grammemes,
                                 on_duplicate_key_update: { conflict_target: [:name] },
                                 returning: [:id, :name]

    restrictions = xml.xpath('//dictionary//restrictions/restr').map do |xml_restriction|
      left = xml_restriction.css('left').first
      right = xml_restriction.css('right').first
      Restriction.new(typ: xml_restriction['type'],
                      auto: !!!xml_restriction['auto'],
                      left_type: left['type'],
                      left_grammeme: Grammeme.find_by(name: left['type']),
                      right_type: right['type'],
                      right_grammeme: Grammeme.find_by(name: right['type']))
    end
    Restriction.import restrictions, on_duplicate_key_ignore: true

    xml.xpath('//dictionary//lemmata/lemma').each_with_index do |xml_lemma, index|
      lemma = Lemma.create lemma_id: xml_lemma['id'].to_i, rev: xml_lemma['rev'].to_i
      xml_lemma.xpath('l').each do |xl|
        lemma_text = LemmaText.create lemma: lemma, text: xl['t']
        LemmaGrammeme.import xl.xpath('g').map { |xg| add_grammeme(lemma_text, xg) }
      end

      xml_lemma.xpath('f').each do |xf|
        lemma_form = LemmaForm.create lemma: lemma, text: xf['t']
        # binding.pry if xf['t'] == 'бежала'
        LemmaGrammeme.import xf.xpath('g').map { |xg| add_grammeme(lemma_form, xg) }
      end
      puts "Lemma index #{index}" if (index / 100).zero?
    end

    link_types = xml.xpath('//dictionary//link_types/type').map do |xml_link_type|
      LinkType.new id: xml_link_type['id'].to_i,
                   name: xml_link_type.text
    end
    LinkType.import link_types, on_duplicate_key_ignore: true

    links = xml.xpath('//dictionary//links/link').map do |xml_link|
      Link.new id: xml_link['id'].to_i,
               lemma_from: Lemma.find_by(lemma_id: xml_link['from']),
               lemma_to: Lemma.find_by(lemma_id: xml_link['to']),
               typ: xml_link['type']
    end
    Link.import links, on_duplicate_key_ignore: true
  end

  private

  def self.add_grammeme(lemma_text, xg)
    LemmaGrammeme.new kind_type: lemma_text.class.name,
                      kind_id: lemma_text.id,
                      # grammeme_id: Grammeme.find_by(name: xg['v'])&.id
                      grammeme_id: grammeme_find(xg['v'])
  end

  def self.grammeme_find(verbose)
    out = @grammemes.results.find { |id, name| name == verbose }
    return unless out

    out[0]
  end
end
