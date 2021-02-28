#!/usr/bin/env bash
# запуск без сброса БД

docker-compose down
docker-compose build
docker-compose up -d

curl http://localhost:3001/ping.json
docker-compose logs -f
