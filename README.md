# Opencorps

- [словарь словоформ русского языка](http://opencorpora.org/dict.php)
- [gem 'activerecord-import'](https://github.com/zdennis/activerecord-import) - batch insert in Postgres
- [о работе с большими xml](https://www.viget.com/articles/parsing-big-xml-files-with-nokogiri/)

## Импорт

Выполняется по

```ruby
Import.call 
```

или 
```shell
spring rake import:xml\[/Users/dog/Downloads/dict.opcorpora.xml\]
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

```postgresql
-- получить грамемы словоформы
SELECT f.lemma_id, g.name, g.alias, g.description
FROM lemma_forms f,
     lemma_grammemes lg,
     grammemes g
WHERE f.text = 'бежала'
  AND lg.kind_type = 'LemmaForm'
  AND lg.kind_id = f.id
  AND lg.grammeme_id = g.id 
group by f.lemma_id, g.name, g.alias, g.description
```

```postgresql
-- случайные словоформы в количестве
select text
from lemma_forms f
where true
--and text like 'заштри%'
 ORDER BY RANDOM()
limit 1000
```

```postgresql
-- взять грамемы форм по её id
select g.*
from lemma_forms f, lemma_grammemes lg, grammemes g
where f.id = 6999337
and f.id = lg.kind_id
and lg.kind_type = 'LemmaForm'
```

```postgresql
-- взять тексты всех форм грамемы
select f.text
from lemmas l, lemma_texts t, lemma_forms f
where l.id = t.lemma_id
and t.text = 'ёж'
and f.lemma_id = l.id
```

проверка файла со словами
одна строка - одно слово
начинать со строки 1_208_000
```shell
File.open( '_backup/form_texts.csv').each_with_index {|f, j| next if j < 1208000; puts f if Obscene.is?
(f); puts j if j % 1000 == 0 }
```
