##
# = Леммы
#
class Api::V1::LinksController < Api::V1::BaseController

  # = Получить грамемы словоформы
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/links/1
  # отдаёт
  #  {"link":{"id":1,"lemma_from_id":168891,"lemma_to_id":168892,"type_id":1,"created_at":"2021-02-28T20:40:52.629Z","updated_at":"2021-02-28T20:40:52.629Z"}}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_link) unless (@link = Link.find_by(id: id))

    render json: { link: @link }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
