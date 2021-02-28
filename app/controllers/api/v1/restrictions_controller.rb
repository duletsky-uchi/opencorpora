##
# = Леммы
#
class Api::V1::RestrictionsController < Api::V1::BaseController

  # = Получить ограничение использования лемм, форм
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/restrictions/386
  # отдаёт
  #  {"restriction":{"id":386,"typ":"obligatory","auto":false,"left_type":"lemma","left_grammeme_id":"2","right_type":"lemma","right_grammeme_id":"19","created_at":"2021-02-28T21:04:39.543Z","updated_at":"2021-02-28T21:04:39.543Z"}}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_link) unless (@restriction = Restriction.find_by(id: id))

    render json: { restriction: @restriction }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
