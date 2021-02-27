##
# = Получить по грамемам словоформы
#
class Api::V1::FormsByGramemesController < Api::V1::BaseController

  # = Получить грамемы словоформы
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/forms_by_gramemes/femn,sing,past,indc
  # отдаёт
  #  {"grammemes":[{"lemma_id":237957,"name":"femn","alias":"жр","description":"женский род"},{"lemma_id":237957,"name":"sing","alias":"ед","description":"единственное число"},{"lemma_id":237957,"name":"past","alias":"прош","description":"прошедшее время"},{"lemma_id":237957,"name":"indc","alias":"изъяв","description":"изъявительное наклонение"},{"lemma_id":237962,"name":"femn","alias":"жр","description":"женский род"},{"lemma_id":237962,"name":"sing","alias":"ед","description":"единственное число"},{"lemma_id":237962,"name":"past","alias":"прош","description":"прошедшее время"},{"lemma_id":237962,"name":"indc","alias":"изъяв","description":"изъявительное наклонение"}]}%
  def show
    return err(:empty_grammemes) if params[:grammemes].empty?
    return err(:empty_grammemes) if grammemes.empty?

    sql = Lemma.send(:sanitize_sql_array, [sql_template, grammemes])
    out = ActiveRecord::Base.connection.select_all(sql)

    render json: { forms: out }
  end

  def sql_template
    <<~SQL
            SELECT f.lemma_id, f.text
      FROM lemma_forms f,
           lemma_grammemes lg,
           grammemes g
      WHERE lg.kind_type = 'LemmaForm'
      AND lg.kind_id = f.id
      AND lg.grammeme_id = g.id
      AND g.name IN (?)
      LIMIT 10
    SQL
  end

  private

  def grammemes
    @grammemes ||= params[:grammemes].split(/\s*,\s*/)
  end
end
