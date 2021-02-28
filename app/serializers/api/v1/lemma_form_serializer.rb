# сериализатор текста леммы
#
class Api::V1::LemmaFormSerializer < ActiveModel::Serializer
  attributes :id,
             :lemma_id,
             :text,
             :grammemes
end
