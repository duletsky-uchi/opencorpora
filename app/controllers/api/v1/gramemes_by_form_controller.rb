##
# = Получить грамемы словоформы
#
class Api::V1::GramemesByFormController < Api::V1::BaseController

  # = Получить грамемы словоформы
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/gramemes_by_form/бежала
  # отдаёт
  #  {"grammemes":[{"lemma_id":237957,"name":"femn","alias":"жр","description":"женский род"},{"lemma_id":237957,"name":"sing","alias":"ед","description":"единственное число"},{"lemma_id":237957,"name":"past","alias":"прош","description":"прошедшее время"},{"lemma_id":237957,"name":"indc","alias":"изъяв","description":"изъявительное наклонение"},{"lemma_id":237962,"name":"femn","alias":"жр","description":"женский род"},{"lemma_id":237962,"name":"sing","alias":"ед","description":"единственное число"},{"lemma_id":237962,"name":"past","alias":"прош","description":"прошедшее время"},{"lemma_id":237962,"name":"indc","alias":"изъяв","description":"изъявительное наклонение"}]}%
  def show
    return err(:empty_form) if params[:form].empty?

    sql = Lemma.send(:sanitize_sql_array, [sql_template, params[:form]])
    out = ActiveRecord::Base.connection().select_all(sql)

    render json: { grammemes: out }
  end

  def sql_template
    sql = <<~SQL
      SELECT f.lemma_id, g.name, g.alias, g.description
      FROM lemma_forms f,
           lemma_grammemes lg,
           grammemes g
      WHERE f.text = ?
      AND lg.kind_type = 'LemmaForm'
      AND lg.kind_id = f.id
      AND lg.grammeme_id = g.id
      LIMIT 10
    SQL
  end
end
