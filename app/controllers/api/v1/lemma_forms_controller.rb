##
# = Леммы
#
class Api::V1::LemmaFormsController < Api::V1::BaseController

  # = Получить форму леммы
  # Запрос
  #  curl http://localhost:3000/api/v1/lemma_forms/8323402
  # отдаёт
  #  {"lemma_form":{"id":8323402,"lemma_id":648187,"text":"ёж","grammemes":[{"id":23870599,"kind_type":"LemmaForm","kind_id":8323402,"grammeme_id":14908,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"},{"id":23870600,"kind_type":"LemmaForm","kind_id":8323402,"grammeme_id":14914,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"}]}}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_lemma) unless (@lemma_form = LemmaForm.find_by(id: id))

    render json: { lemma_form: ::Api::V1::LemmaFormSerializer.new(@lemma_form) }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
