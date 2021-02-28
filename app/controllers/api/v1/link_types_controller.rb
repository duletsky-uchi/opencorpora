##
# = Леммы
#
class Api::V1::LinkTypesController < Api::V1::BaseController

  # = Получить типы свялей
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/link_types/1
  # отдаёт
  #  {"link_type":{"id":1,"name":"ADJF-ADJS","created_at":"2021-02-28T20:33:45.093Z","updated_at":"2021-02-28T20:33:45.093Z"}}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_link) unless (@link_type = LinkType.find_by(id: id))

    render json: { link_type: @link_type }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
