##
# = API - работа c корпусом русского языка OpenCorpora
#
class Api::V1::BaseController < ActionController::Base

  def err(msg, status: :unprocessable_entity)
    render json: {error: msg}, status: status
  end

end
