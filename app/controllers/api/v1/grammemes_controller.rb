##
# = Леммы
#
class Api::V1::GrammemesController < Api::V1::BaseController

  # = Получить грамему
  # Запрос
  #  curl http://localhost:3000/api/v1/grammemes/14886
  # отдаёт
  #  {"grammeme":{"id":14886,"name":"VERB","parent":"","alias":"ГЛ","description":"глагол (личная форма)","created_at":"2021-02-23T15:49:22.248Z","updated_at":"2021-02-23T15:49:22.248Z"}}%
  def show
    return err(:empty_id) if id.zero?
    return err(:empty_grammeme) unless (@grammeme = Grammeme.find_by(id: id))

    render json: { grammeme: @grammeme }
  end

  private

  def id
    @id ||= params[:id].to_i
  end
end
