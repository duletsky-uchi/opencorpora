# сериализатор текста леммы
#
class Api::V1::LemmaTextSerializer < ActiveModel::Serializer
  attributes :id,
             :lemma_id,
             :text,
             :grammemes
end
