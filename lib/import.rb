# Импорт xml c http://opencorpora.org/dict.php
module Import

  def self.call(xml_name = "#{Rails.root}/spec/fixtures/dic.xml", log: true)
    # xml = Nokogiri::XML(open("#{Rails.root}/spec/fixtures/dic.xml"))
    # xml = Nokogiri::XML(open('/Users/dog/Downloads/dict.opcorpora.xml'))
    xml = Nokogiri::XML(open(xml_name))

    Grammeme.delete_all
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
                      left_grammeme: Grammeme.find_by(name: left.text),
                      right_type: right['type'],
                      right_grammeme: Grammeme.find_by(name: right.text))
    end
    Restriction.import restrictions, on_duplicate_key_ignore: true

    xml.xpath('//dictionary//lemmata/lemma').each_with_index do |xml_lemma, index|
      lemma = Lemma.create lemma_id: xml_lemma['id'].to_i, rev: xml_lemma['rev'].to_i

      lemma_texts = []
      xml_lemma.xpath('l').each do |xl|
        lemma_text = LemmaText.new lemma: lemma, text: xl['t']
        # LemmaGrammeme.import xl.xpath('g').map { |xg| add_grammeme(lemma_text, xg) }
        xl.xpath('g').each do |xg|
          lemma_text.grammemes.build kind_type: lemma_text.class.name,
                                     kind_id: lemma_text.id,
                                     grammeme_id: grammeme_find(xg['v'])
        end
        lemma_texts << lemma_text
        # LemmaText.import lemma_text, recursive: true
      end
      LemmaText.import lemma_texts, recursive: true, timestamps: false

      lemma_forms = []
      xml_lemma.xpath('f').each do |xf|
        lemma_form = LemmaForm.new lemma: lemma, text: xf['t']
        xf.xpath('g').each do |xg|
          lemma_form.grammemes.build kind_type: lemma_form.class.name,
                                     kind_id: lemma_form.id,
                                     grammeme_id: grammeme_find(xg['v'])
        end
        lemma_forms << lemma_form
      end
      LemmaForm.import lemma_forms,
                       recursive: true,
                       on_duplicate_key_ignore: true,
                       timestamps: false

      puts "Lemma index #{index}" if (index % 100).zero? && log
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
    Link.import links #, on_duplicate_key_ignore: true

    LemmaForm.where(created_at: nil).update_all created_at: Time.zone.now
    LemmaForm.where(updated_at: nil).update_all updated_at: Time.zone.now
    LemmaText.where(created_at: nil).update_all created_at: Time.zone.now
    LemmaText.where(updated_at: nil).update_all updated_at: Time.zone.now
    LemmaGrammeme.where(created_at: nil).update_all created_at: Time.zone.now
    LemmaGrammeme.where(updated_at: nil).update_all updated_at: Time.zone.now

    true
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
