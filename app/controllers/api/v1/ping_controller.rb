##
# = Проверка работоспособности приложения
#
# Для проверки корректности запуска докера
#
# curl http://localhost:3000/api/v1/ping.json
#   {"ping":"pong"}%
#
class Api::V1::PingController < ActionController::Base

  def index
    render json: {ping: :pong}
  end
end
