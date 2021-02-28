#!/usr/bin/env bash

docker-compose down
docker-compose build
docker-compose up -d
#docker-compose run app rake db:create db:migrate db:seed ar:fix_primary_key RAILS_ENV=production
docker-compose run app rake db:create db:migrate db:seed RAILS_ENV=production

URL='http://localhost:3001/api/'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "\n-------------------"
#echo -e "${GREEN}Просмотр документации из докера${NC} - ${URL}"
#echo -e "Например, ${URL}/B2t/Api/V1/Teachers/CheckAddJobsController.html"
#echo -e "${GREEN}Документации на шоте${NC} - https://43859.shot-uchi.ru/api-docs/index.html\n"
#echo -e "\n-------------------"
#echo -e "${GREEN}Для восстановления дампа БД с прода${NC} - docker-compose run app rake db:restore pattern=dump.sql DISABLE_DATABASE_ENVIRONMENT_CHECK=1\n"

#docker-compose run app rake db:check_sessions:seed RAILS_ENV=production
#docker-compose run app rake db:subject_chapter_topic:seed RAILS_ENV=production
#docker-compose run app rake ar:fix_primary_key RAILS_ENV=production

#open ${URL}/README_md.html
curl http://localhost:3001/ping.json

docker-compose logs -f
