# Opencorps

Импорт словоформ русского языка в БД Postgres.
Сейчас в нем
- 5М словоформ 
- 400К лемм
- 14М определений грамем для словоформ и лемм 

Может быть полезно для:
- определния грамем слово (бежала -> глагол, прошеднее время, ед.ч. одуш)
- подбору по грамемам слов (глагол, прошеднее время, ед.ч. -> стояла, смотрела, ...)
- определения для словоформы леммы

Ссылки:
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

## Todo

- docker-compose 
- генерация текста по наборам граммем
- импорт не из файла, а сразу с сайта OpenCorpora
- на index счетчики числа лемм, словоформ, грамем
- на index формы запросов к api
- heroku
- доки на api в public
