# Opencorps

http://opencorpora.org/dict.php
словарь словоформ русского языка

Импорт в Postgres

## Импорт

Выполняется по

```ruby
Import.call 
```

```ruby
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
    LemmaGrammeme.create grammeme_type: ltext.class.name, grammeme_id: ltext.id, v: xg['v']
  end
end
```

## Запросы

```postgresql
-- поиск определения слова (грамем)
SELECT f.lemma_id, g.name, g.alias, g.description
FROM lemma_forms f,
     lemma_grammemes lg,
     grammemes g
WHERE f.text = 'бежала'
  AND lg.kind_type = 'LemmaForm'
  AND lg.kind_id = f.id
  AND lg.grammeme_id = g.id
GROUP BY f.lemma_id, g.name, g.alias, g.description
```
