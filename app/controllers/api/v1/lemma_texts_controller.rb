##
# = Леммы
#
class Api::V1::LemmaTextsController < Api::V1::BaseController

  # = Получить текст леммы
  # Запрос
  #  curl http://localhost:3000/api/v1/lemma_texts/1040293
  # отдаёт
  #  {"lemma_text":{"id":1040293,"lemma_id":1039950,"text":"меряем","grammemes":[{"id":38830023,"kind_type":"LemmaText","kind_id":1040293,"grammeme_id":14889,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"},{"id":38830024,"kind_type":"LemmaText","kind_id":1040293,"grammeme_id":14945,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"},{"id":38830025,"kind_type":"LemmaText","kind_id":1040293,"grammeme_id":14958,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"},{"id":38830026,"kind_type":"LemmaText","kind_id":1040293,"grammeme_id":14969,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"},{"id":38830027,"kind_type":"LemmaText","kind_id":1040293,"grammeme_id":14970,"created_at":"2021-02-23T18:25:48.116Z","updated_at":"2021-02-23T18:33:12.450Z"}]}}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_lemma) unless (@lemma_text = LemmaText.find_by(id: id))

    render json: { lemma_text: ::Api::V1::LemmaTextSerializer.new(@lemma_text) }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
