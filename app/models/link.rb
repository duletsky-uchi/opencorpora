class Link < ApplicationRecord
  belongs_to :lemma_from, class_name: 'Lemma'
  belongs_to :lemma_to, class_name: 'Lemma'
end
