# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_16_220940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bans", force: :cascade do |t|
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at"
    t.index ["room_id"], name: "index_bans_on_room_id"
    t.index ["user_type", "user_id"], name: "index_bans_on_user_type_and_user_id"
  end

  create_table "broadcastings", force: :cascade do |t|
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.string "default_text"
    t.integer "default_sticker_ids", array: true
    t.string "report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "chapters", comment: "Главы и разделы тестов с разбивкой по предметам", force: :cascade do |t|
    t.string "color", limit: 16
    t.integer "topic_id"
    t.integer "position"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "advanced", default: false, null: false
    t.string "nick", limit: 16
    t.boolean "active", default: true
  end

  create_table "chapters_learning_levels", force: :cascade do |t|
    t.bigint "chapter_id"
    t.bigint "learning_level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_chapters_learning_levels_on_chapter_id"
    t.index ["learning_level_id"], name: "index_chapters_learning_levels_on_learning_level_id"
  end

  create_table "check_generations", comment: "Генерации - варианты заданий, одному ученику только одна из генераций, антисписывание", force: :cascade do |t|
    t.integer "check_job_id"
    t.string "name"
    t.string "kind", limit: 32
    t.jsonb "data", default: {}
    t.string "result"
    t.text "solution"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "args", default: {}, comment: "доп-настройки показа, специфичные для механики"
  end

  create_table "check_jobs", comment: "Задания (атомы, вопросы) тестов", force: :cascade do |t|
    t.integer "subject"
    t.integer "learning_level_id"
    t.integer "topic_id"
    t.integer "chapter_id"
    t.integer "lesson_id"
    t.integer "teacher_id"
    t.integer "group_id"
    t.string "name"
    t.string "difficulty", limit: 1, default: "A"
    t.integer "difficulty_custom", limit: 2, comment: "Индивидуальный вес задания"
    t.boolean "base", default: false, comment: "отлиносится ли к базовому тесту (создан методистами)"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "from_check_job_id", comment: "заполняется в teahcer/add_jobs при копировании заданий, содержит id-задания оригинала"
    t.boolean "not_for_teacher", default: false, comment: "флаг непоказа учителю, и показа методисту"
    t.index ["chapter_id"], name: "index_check_jobs_on_chapter_id"
    t.index ["group_id"], name: "index_check_jobs_on_group_id"
    t.index ["learning_level_id"], name: "index_check_jobs_on_learning_level_id"
    t.index ["lesson_id"], name: "index_check_jobs_on_lesson_id"
    t.index ["teacher_id"], name: "index_check_jobs_on_teacher_id"
    t.index ["topic_id"], name: "index_check_jobs_on_topic_id"
  end

  create_table "check_lessons", comment: "Проведение теста (на уроке)", force: :cascade do |t|
    t.integer "check_id"
    t.integer "topic_id"
    t.integer "chapter_id"
    t.integer "teacher_id"
    t.integer "group_id"
    t.integer "subject_id"
    t.string "name"
    t.boolean "active", default: false, comment: "true когда урок доступен для учеников"
    t.boolean "draft", default: false, comment: "true после копирования базового теста в учительский, до его утверждения учителем"
    t.date "start", comment: "Дата начала возможности выполнения"
    t.date "finish", comment: "Дата окончания возможности выполнения"
    t.integer "time_limit", comment: "Лимит выполнения урока, в минутах"
    t.jsonb "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "check_way_id", default: 1, comment: "режим проведения урока - на уроке, дома, ..."
    t.boolean "closed", default: false, comment: "отметка завершения урока - по дате завершения или явным изменением"
    t.index ["chapter_id"], name: "index_check_lessons_on_chapter_id"
    t.index ["check_id"], name: "index_check_lessons_on_check_id"
    t.index ["group_id"], name: "index_check_lessons_on_group_id"
    t.index ["subject_id"], name: "index_check_lessons_on_subject_id"
    t.index ["teacher_id"], name: "index_check_lessons_on_teacher_id"
    t.index ["topic_id"], name: "index_check_lessons_on_topic_id"
  end

  create_table "check_lessons_students", comment: "Списки учеников на уроке", force: :cascade do |t|
    t.integer "check_lesson_id"
    t.integer "student_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "period", default: 0, comment: "продолжительность прохождения урока учеником, секунды"
    t.index ["check_lesson_id"], name: "index_check_lessons_students_on_check_lesson_id"
    t.index ["student_id"], name: "index_check_lessons_students_on_student_id"
  end

  create_table "check_lessons_students_check_jobs", comment: "Списки заданий ученикам на уроке", force: :cascade do |t|
    t.integer "check_lesson_id"
    t.integer "student_id"
    t.integer "check_job_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_job_id"], name: "index_check_lessons_students_check_jobs_on_check_job_id"
    t.index ["check_lesson_id"], name: "index_check_lessons_students_check_jobs_on_check_lesson_id"
    t.index ["student_id"], name: "index_check_lessons_students_check_jobs_on_student_id"
  end

  create_table "check_modes", comment: "Тип задания: тест, контрольная...", force: :cascade do |t|
    t.string "name", limit: 64
    t.string "nick", limit: 16
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_scales", comment: "Вид задания: базовый, ...", force: :cascade do |t|
    t.string "name", limit: 64
    t.string "nick", limit: 16
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_sessions", comment: "Отметка выполнения заданий учеником на уроке", force: :cascade do |t|
    t.integer "check_lesson_id"
    t.integer "student_id"
    t.integer "check_job_id"
    t.datetime "finish", comment: "когда был дан ответ, null - ответа еще не было"
    t.jsonb "answer", default: {}
    t.boolean "right", default: false, comment: "правильный ли был дан ответ, заполняется при update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "empty", default: true, comment: "флаг считать ли ответ пустым, сессии с пустыми ответами не участвуют в расчете баллов за урок, заполняется фронтом"
    t.jsonb "raw", default: {}, comment: "необработаный ответ с фронта"
    t.boolean "done", default: false, comment: "флаг отметки выполнения задания, для работы с частично заполенными ответами"
    t.index ["check_job_id"], name: "index_check_sessions_on_check_job_id"
    t.index ["check_lesson_id"], name: "index_check_sessions_on_check_lesson_id"
    t.index ["student_id"], name: "index_check_sessions_on_student_id"
  end

  create_table "check_ways", comment: "режим проведения - на уроке, дома", force: :cascade do |t|
    t.string "nick", limit: 16
    t.string "name", limit: 64
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nick"], name: "index_check_ways_on_nick", unique: true
  end

  create_table "checks", comment: "Тесты", force: :cascade do |t|
    t.integer "subject"
    t.integer "learning_level_id"
    t.integer "topic_id"
    t.integer "chapter_id"
    t.integer "lesson_id"
    t.integer "teacher_id"
    t.integer "group_id"
    t.string "name"
    t.boolean "active", default: true
    t.boolean "draft", default: false, comment: "true после копирования базового теста в учительский, до его утверждения учителем"
    t.boolean "base", default: false, comment: "базовый ли тест (создан методистами)"
    t.integer "from_check_id", comment: "код теста с которого скопирован данный"
    t.integer "check_scale_id"
    t.integer "check_mode_id"
    t.jsonb "data"
    t.integer "time_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_checks_on_chapter_id"
    t.index ["from_check_id"], name: "index_checks_on_from_check_id"
    t.index ["group_id"], name: "index_checks_on_group_id"
    t.index ["learning_level_id"], name: "index_checks_on_learning_level_id"
    t.index ["lesson_id"], name: "index_checks_on_lesson_id"
    t.index ["teacher_id"], name: "index_checks_on_teacher_id"
    t.index ["topic_id"], name: "index_checks_on_topic_id"
  end

  create_table "checks_check_jobs", comment: "Принадлежность заданий тестам", force: :cascade do |t|
    t.integer "check_id"
    t.integer "check_job_id"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_checks_check_jobs_on_check_id"
    t.index ["check_job_id"], name: "index_checks_check_jobs_on_check_job_id"
  end

  create_table "custom_events", force: :cascade do |t|
    t.string "user_type"
    t.integer "user_id"
    t.integer "room_id"
    t.string "kind"
    t.text "referrer"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type", "user_id", "kind"], name: "index_custom_events_on_user_type_and_user_id_and_kind"
  end

  create_table "games", comment: "Игры", force: :cascade do |t|
    t.integer "teacher_id", comment: "Учитель"
    t.integer "lesson_id", comment: "Сложность - ссылка на раздел topic.chapter.lesson"
    t.integer "chapter_id", comment: "Урок, lesson - раздел из topics"
    t.string "name", comment: "Название, из chapter"
    t.boolean "active", default: true, comment: "Проходит ли игра сейчас, если окончена - false"
    t.integer "teams_number", default: 2, comment: "Число команд"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id", comment: "Ученик"
    t.integer "player_id", comment: "Номер персонажа, выбранного учеником"
    t.index ["student_id", "active"], name: "index_games_on_student_id_and_active"
    t.index ["teacher_id", "active"], name: "index_games_on_teacher_id_and_active"
  end

  create_table "grammemes", comment: "Openсorpa, граммемы, <grammeme>", force: :cascade do |t|
    t.string "name", null: false, comment: "название грамемы - neut"
    t.string "parent", null: false, comment: "родительская грамема - GNdr"
    t.string "alias", null: false, comment: "краткое обозначение - ср"
    t.string "description", null: false, comment: "описание - средний род"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["name"], name: "index_grammemes_on_name", unique: true
  end

  create_table "hints", force: :cascade do |t|
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.string "kind", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type", "user_id", "kind"], name: "index_hints_on_user_type_and_user_id_and_kind", unique: true
  end

  create_table "learning_levels", comment: "Уровень обучения - год обучения, позднее будет читаться из Учи.Ру", force: :cascade do |t|
    t.integer "value"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lemma_forms", comment: "словоформы лемм, <f>", force: :cascade do |t|
    t.bigint "lemma_id", comment: "код леммы"
    t.string "text", comment: "текст словоформы <t>"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.index ["lemma_id", "text"], name: "index_lemma_forms_on_lemma_id_and_text"
    t.index ["lemma_id"], name: "index_lemma_forms_on_lemma_id"
  end

  create_table "lemma_grammemes", comment: "Openсorpa, граммемы леммы, <g>", force: :cascade do |t|
    t.string "kind_type"
    t.bigint "kind_id", comment: "тип грамемы: text, form"
    t.bigint "grammeme_id", null: false, comment: "ссылка на грамему"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["grammeme_id"], name: "index_lemma_grammemes_on_grammeme_id"
    t.index ["kind_type", "kind_id", "grammeme_id"], name: "index_lemma_grammemes_on_kind_type_and_kind_id_and_grammeme_id"
    t.index ["kind_type", "kind_id"], name: "index_lemma_grammemes_on_kind_type_and_kind_id"
  end

  create_table "lemma_texts", comment: "тексты лемм, <l>", force: :cascade do |t|
    t.bigint "lemma_id", comment: "код леммы"
    t.string "text", comment: "текст словоформы <t>"
    t.datetime "created_at", precision: 6, default: -> { "now()" }
    t.datetime "updated_at", precision: 6, default: -> { "now()" }
    t.index ["lemma_id", "text"], name: "index_lemma_texts_on_lemma_id_and_text", unique: true
    t.index ["lemma_id"], name: "index_lemma_texts_on_lemma_id"
  end

  create_table "lemmas", comment: "Openсorpa леммы", force: :cascade do |t|
    t.bigint "lemma_id", null: false, comment: "айди леммы"
    t.integer "rev", null: false, comment: "ревизия описания леммы"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["id", "rev"], name: "index_lemmas_on_id_and_rev", unique: true
    t.index ["lemma_id", "rev"], name: "index_lemmas_on_lemma_id_and_rev", unique: true
  end

  create_table "link_types", comment: "типы связей, <link_types><type>", force: :cascade do |t|
    t.string "name", default: "t", null: false, comment: "название связи - NAME-PATR"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "links", force: :cascade do |t|
    t.bigint "lemma_from_id", null: false
    t.bigint "lemma_to_id", null: false
    t.string "typ"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["lemma_from_id"], name: "index_links_on_lemma_from_id"
    t.index ["lemma_to_id"], name: "index_links_on_lemma_to_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_type", null: false
    t.jsonb "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "broadcasting_id"
    t.integer "room_id"
    t.datetime "deleted_at"
    t.bigint "deleted_by_user_id"
    t.string "deleted_by_user_type"
    t.index ["broadcasting_id"], name: "index_messages_on_broadcasting_id"
    t.index ["room_id", "created_at"], name: "index_messages_on_room_id_and_created_at"
  end

  create_table "messages_readers", force: :cascade do |t|
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_messages_readers_on_message_id"
    t.index ["user_type", "user_id", "message_id"], name: "index_messages_readers_on_user_type_and_user_id_and_message_id", unique: true
  end

  create_table "pins", force: :cascade do |t|
    t.bigint "message_id"
    t.datetime "created_at"
    t.integer "created_user_id"
    t.string "created_user_type"
    t.datetime "deleted_at"
    t.index ["message_id"], name: "index_pins_on_message_id"
  end

  create_table "restrictions", comment: "Ограничения на совместное употребление лемм, <rest>", force: :cascade do |t|
    t.string "typ", null: false, comment: "тип ограничения - maybe"
    t.boolean "auto", default: true, null: false, comment: "авто - 0"
    t.string "left_type", null: false, comment: "тип леммы слева - lemma"
    t.string "left_grammeme_id", null: false, comment: "грамема слева - NOUN"
    t.string "right_type", null: false, comment: "тип леммы справа - lemma"
    t.string "right_grammeme_id", null: false, comment: "грамема справа - ANim"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["left_grammeme_id", "right_grammeme_id"], name: "index_restrictions_on_left_grammeme_id_and_right_grammeme_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "class_code"
    t.index "COALESCE(class_code, ''::character varying), COALESCE(teacher_id, 0), COALESCE(student_id, 0)", name: "unique_index_rooms_on_class_code_and_teacher_id_and_student_id", unique: true
    t.index ["class_code", "teacher_id", "student_id"], name: "index_rooms_on_class_code_and_teacher_id_and_student_id"
    t.index ["class_code"], name: "index_rooms_on_class_code"
    t.index ["teacher_id"], name: "index_rooms_on_teacher_id"
  end

  create_table "sessions", comment: "Сессии прохождения карточек", force: :cascade do |t|
    t.integer "card_id", comment: "Карточка"
    t.integer "teacher_id", comment: "Учитель"
    t.integer "game_id", comment: "Игра - запись о прохождении игры-урока"
    t.integer "team_id", comment: "Команда - 1я или 2я"
    t.integer "lesson_id", comment: "Сложность - ссылка на раздел topic.chapter.lesson"
    t.integer "chapter_id", comment: "Урок, lesson - раздел из topics"
    t.boolean "completed", default: false, comment: "Продена ли"
    t.string "event", limit: 32, comment: "Событие: начало прохождения, поздрав, ..."
    t.boolean "error", default: false, comment: "Ошибка - была ли при прохождении карточки"
    t.integer "score", default: 0, comment: "Счет - число баллов за карточку\n"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id", comment: "Ученик"
    t.index ["created_at"], name: "index_sessions_on_created_at"
    t.index ["error"], name: "index_sessions_on_error"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_settings_on_name", unique: true
  end

  create_table "short_urls", comment: "короткие ссылки", force: :cascade do |t|
    t.string "short", comment: "короткая ссылка"
    t.string "original", comment: "исходная ссылка"
    t.string "slug", comment: "хеш исходной ссылки"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url_type", comment: "Тип короткой ссылки"
    t.index ["slug"], name: "index_short_urls_on_slug"
  end

  create_table "spent_cards", force: :cascade do |t|
    t.integer "sticker_ids", null: false, array: true
    t.integer "cards_count", null: false
    t.integer "user_id", null: false
    t.string "user_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sticker_ids_nullable", array: true
    t.string "gif_src"
    t.index ["user_id", "user_type"], name: "index_spent_cards_on_user_id_and_user_type"
  end

  create_table "stickerpacks", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stickerpacks_on_name", unique: true
  end

  create_table "stickers", force: :cascade do |t|
    t.bigint "stickerpack_id", null: false
    t.string "image_path"
    t.string "animation_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost", null: false
    t.boolean "personal", default: false
    t.string "name"
    t.index ["name"], name: "index_stickers_on_name", unique: true
    t.index ["stickerpack_id"], name: "index_stickers_on_stickerpack_id"
  end

  create_table "student_personal_stickers", force: :cascade do |t|
    t.integer "student_id"
    t.string "sticker_names", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_personal_stickers_on_student_id", unique: true
  end

  create_table "subjects", comment: "Предметы, временная таблица, позднее будет читаться из Учи.Ру", force: :cascade do |t|
    t.string "name", limit: 64
    t.string "nick", limit: 16
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", null: false
    t.string "nick"
    t.bigint "subject_id"
    t.integer "position", null: false
    t.boolean "advanced", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["subject_id"], name: "index_topics_on_subject_id"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.string "user_type"
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "last_read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type", "user_id", "room_id"], name: "index_user_rooms_on_user_type_and_user_id_and_room_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bans", "rooms", on_delete: :cascade
  add_foreign_key "links", "lemmas", column: "lemma_from_id"
  add_foreign_key "links", "lemmas", column: "lemma_to_id"
  add_foreign_key "messages", "broadcastings"
  add_foreign_key "messages_readers", "messages", on_delete: :cascade
  add_foreign_key "pins", "messages"
  add_foreign_key "stickers", "stickerpacks", on_delete: :cascade
  add_foreign_key "topics", "subjects"
end
