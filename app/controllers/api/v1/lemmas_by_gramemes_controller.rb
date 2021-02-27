##
# = Получить по грамемам леммы
#
class Api::V1::LemmasByGramemesController < Api::V1::BaseController

  # = Получить грамемы словоформы
  # Внимание - грамемы могут относится к нескольким леммам
  # Запрос
  #  curl http://localhost:3000/api/v1/lemmas_by_gramemes/INFN,impf,intr
  # отдаёт
  #  {"forms":[{"lemma_id":648200,"text":"ёжиться"},{"lemma_id":648220,"text":"ёрзать"},{"lemma_id":648226,"text":"ёрничать"},{"lemma_id":649770,"text":"абонироваться"},{"lemma_id":650042,"text":"абсорбироваться"},{"lemma_id":650074,"text":"абстрагироваться"},{"lemma_id":650370,"text":"авалироваться"},{"lemma_id":651039,"text":"авралить"},{"lemma_id":651316,"text":"автоклавизироваться"},{"lemma_id":651396,"text":"автоматизироваться"}]}%
  def show
    return err(:empty_grammemes) if params[:grammemes].empty?
    return err(:empty_grammemes) if grammemes.empty?

    sql = Lemma.send(:sanitize_sql_array, [sql_template, grammemes, grammemes.size])
    out = ActiveRecord::Base.connection.select_all(sql)

    render json: { lemmas: out }
  end

  def sql_template
    <<~SQL
      -- список лемм соотвествующих грамемам
      WITH gids AS (
          SELECT id
          FROM grammemes
          WHERE name IN (?)
      )
      SELECT t.lemma_id, t.text
      FROM lemma_texts t
      WHERE id IN (
          SELECT lg.kind_id
          FROM lemma_grammemes lg
          WHERE lg.kind_type = 'LemmaText'
            AND lg.grammeme_id IN (
              SELECT id
              FROM gids
          )
          GROUP BY lg.kind_id
          HAVING COUNT(*) = ?
      )
      LIMIT 10
    SQL
  end

  private

  def grammemes
    @grammemes ||= params[:grammemes].split(/\s*,\s*/)
  end
end
