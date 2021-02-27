##
# = Получить грамемы леммы
#
class Api::V1::GramemesByTextController < Api::V1::BaseController

  # = Получить грамемы леммы
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl curl http://localhost:3000/api/v1/gramemes_by_text/бежать
  # отдаёт
  #  {"grammemes":[{"lemma_id":673491,"name":"INFN","alias":"ИНФ","description":"глагол (инфинитив)"},{"lemma_id":673496,"name":"INFN","alias":"ИНФ","description":"глагол (инфинитив)"},{"lemma_id":673496,"name":"perf","alias":"сов","description":"совершенный вид"},{"lemma_id":673491,"name":"impf","alias":"несов","description":"несовершенный вид"},{"lemma_id":673491,"name":"intr","alias":"неперех","description":"непереходный"},{"lemma_id":673496,"name":"intr","alias":"неперех","description":"непереходный"}]}%
  def show
    return err(:empty_form) if params[:text].empty?

    sql = Lemma.send(:sanitize_sql_array, [sql_template, params[:text]])
    out = ActiveRecord::Base.connection.select_all(sql)

    render json: { grammemes: out }
  end

  def sql_template
    <<~SQL
      SELECT t.lemma_id, g.name, g.alias, g.description
      FROM lemma_texts t,
           lemma_grammemes lg,
           grammemes g
      WHERE t.text = ?
      AND lg.kind_type = 'LemmaText'
      AND lg.kind_id = t.id
      AND lg.grammeme_id = g.id
      LIMIT 10
    SQL
  end
end
