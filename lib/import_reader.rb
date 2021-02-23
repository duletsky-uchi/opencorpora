# Импорт xml c http://opencorpora.org/dict.php
module ImportReader

  def self.call(xml_name = "#{Rails.root}/spec/fixtures/dic.xml", log: true)
    # xml = Nokogiri::XML(open("#{Rails.root}/spec/fixtures/dic.xml"))
    # xml = Nokogiri::XML(open('/Users/dog/Downloads/dict.opcorpora.xml'))
    # xml = Nokogiri::XML(open(xml_name))

    delete_all

    @grammemes = grammemes(xml_name)
    link_types(xml_name)
    restrictions(xml_name)
    lemmas(xml_name)
    links(xml_name) # обязательно после lemmas, т.к. ссылки на них

    LemmaForm.where(created_at: nil).update_all created_at: Time.zone.now
    LemmaForm.where(updated_at: nil).update_all updated_at: Time.zone.now
    LemmaText.where(created_at: nil).update_all created_at: Time.zone.now
    LemmaText.where(updated_at: nil).update_all updated_at: Time.zone.now
    LemmaGrammeme.where(created_at: nil).update_all created_at: Time.zone.now
    LemmaGrammeme.where(updated_at: nil).update_all updated_at: Time.zone.now

    true
  end

  private

  def self.delete_all
    Grammeme.delete_all
    Link.delete_all
    LinkType.delete_all
    Restriction.delete_all
    Lemma.delete_all
    LemmaText.delete_all
    LemmaForm.delete_all
    LemmaGrammeme.delete_all
  end

  class LemmaNodeHandler < Struct.new(:node)
    def process
      lemma = Lemma.create lemma_id: node['id'], rev: node['rev']

      lemma_text = LemmaText.new lemma: lemma, text: node.at('l')['t']
      node.at('l').elements.each do |xl|
        lemma_text.grammemes.build(kind_type: lemma_text.class.name,
                                   kind_id: lemma_text.id,
                                   grammeme_id: ImportReader.grammeme_find(xl['v']))
      end
      LemmaText.import [lemma_text],
                       timestamps: false,
                       recursive: true

      lemma_forms = node.elements.select { |e| e.name == 'f' }.map do |xf|
        lemma_form = LemmaForm.new lemma: lemma, text: xf.values.first
        xf.elements.each do |xg|
          lemma_form.grammemes.build kind_type: lemma_form.class.name,
                                     kind_id: lemma_form.id,
                                     grammeme_id: ImportReader.grammeme_find(xg['v'])
        end
        lemma_form
      end
      LemmaForm.import lemma_forms.compact,
                       recursive: true,
                       # on_duplicate_key_ignore: true,
                       timestamps: false
    end
  end

  def self.lemmas(xml_name)
    Nokogiri::XML::Reader(File.open(xml_name)).each do |node|
      if node.name == 'lemma' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        LemmaNodeHandler.new(Nokogiri::XML(node.outer_xml).at('./lemma')).process
      end
    end
  end

  class GrammemeNodeHandler < Struct.new(:node)
    def process
      Grammeme.new(name: node.elements.at('name').text,
                   alias: node.elements.at('alias').text,
                   description: node.elements.at('description').text,
                   parent: node.elements.at('parent')&.text || '')
    end
  end

  def self.grammemes(xml_name)
    grammemes = Nokogiri::XML::Reader(File.open(xml_name)).map do |node|
      if node.name == 'grammeme' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        GrammemeNodeHandler.new(Nokogiri::XML(node.outer_xml).at('./grammeme')).process
      end
    end
    Grammeme.import grammemes.compact,
                    on_duplicate_key_update: { conflict_target: [:name] },
                    returning: [:id, :name]
  end

  # link_types = xml.xpath('//dictionary//link_types/type').map do |xml_link_type|
  #   LinkType.new id: xml_link_type['id'].to_i,
  #                name: xml_link_type.text
  # end
  # LinkType.import link_types, on_duplicate_key_ignore: true
  #
  class LinkTypeNodeHandler < Struct.new(:node)
    def process
      LinkType.new(id: node['id'], name: node.text)
    end
  end

  def self.link_types(xml_name)
    link_types = Nokogiri::XML::Reader(File.open(xml_name)).map do |node|
      if node.name == 'type' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        LinkTypeNodeHandler.new(Nokogiri::XML(node.outer_xml).at('./type')).process
      end
    end
    # LinkType.import link_types.compact, on_duplicate_key_ignore: true
    LinkType.import link_types.compact
  end

  # links = xml.xpath('//dictionary//links/link').map do |xml_link|
  #   Link.new id: xml_link['id'].to_i,
  #            lemma_from: Lemma.find_by(lemma_id: xml_link['from']),
  #            lemma_to: Lemma.find_by(lemma_id: xml_link['to']),
  #            typ: xml_link['type']
  # end
  # Link.import links #, on_duplicate_key_ignore: true
  class LinkNodeHandler < Struct.new(:node)
    def process
      Link.new id: node['id'],
               lemma_from: Lemma.find_by(lemma_id: node['from']),
               lemma_to: Lemma.find_by(lemma_id: node['to']),
               typ: node['type']
    end
  end

  def self.links(xml_name)
    links = Nokogiri::XML::Reader(File.open(xml_name)).map do |node|
      if node.name == 'link' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        LinkNodeHandler.new(Nokogiri::XML(node.outer_xml).at('./link')).process
      end
    end
    Link.import links.compact #, on_duplicate_key_ignore: true
  end

  def self.restrictions(xml_name)
    restrictions = Nokogiri::XML::Reader(File.open(xml_name)).map do |node|
      if node.name == 'restr' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        RestrictionNodeHandler.new(Nokogiri::XML(node.outer_xml).at('./restr')).process
      end
    end
    Restriction.import restrictions.compact, on_duplicate_key_ignore: true
  end

  class RestrictionNodeHandler < Struct.new(:node)
    def process
      left = node.elements.at('left')
      right = node.elements.at('right')
      Restriction.new(typ: node['type'],
                      auto: !!!node['auto'],
                      left_type: left['type'],
                      left_grammeme: Grammeme.find_by(name: left.text),
                      right_type: right['type'],
                      right_grammeme: Grammeme.find_by(name: right.text))
    end
  end

  # def self.add_grammeme(lemma_text, xg)
  #   LemmaGrammeme.new kind_type: lemma_text.class.name,
  #                     kind_id: lemma_text.id,
  #                     # grammeme_id: Grammeme.find_by(name: xg['v'])&.id
  #                     grammeme_id: grammeme_find(xg['v'])
  # end

  def self.grammeme_find(verbose)
    out = @grammemes.results.find { |id, name| name == verbose }
    return unless out

    out[0]
  end
end
