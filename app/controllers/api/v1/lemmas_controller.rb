##
# = Леммы
#
class Api::V1::LemmasController < Api::V1::BaseController

  # = Получить грамемы словоформы
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/lemmas/1
  # отдаёт
  #  {"forms":[{"lemma_id":648200,"text":"ёжиться"},{"lemma_id":648220,"text":"ёрзать"},{"lemma_id":648226,"text":"ёрничать"},{"lemma_id":649770,"text":"абонироваться"},{"lemma_id":650042,"text":"абсорбироваться"},{"lemma_id":650074,"text":"абстрагироваться"},{"lemma_id":650370,"text":"авалироваться"},{"lemma_id":651039,"text":"авралить"},{"lemma_id":651316,"text":"автоклавизироваться"},{"lemma_id":651396,"text":"автоматизироваться"}]}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_lemma) unless (@lemma = Lemma.find_by(id: id))

    render json: { lemma: @lemma }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
