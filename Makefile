#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ---------------------------------
	@echo start / stop / restart
	@echo ---------------------------------
	@echo stats / logs / workspace
	@echo clean
	@echo ---------------------------------

_header:
	@echo ------
	@echo Immich
	@echo ------

_urls: _header
	${info }
	@echo ----------------------------------
	@echo [Immich] http://localhost:2283
	@echo ----------------------------------

_start-command:
	@docker compose up -d --remove-orphans

start: _header _start-command _urls

stop:
	@docker compose stop

restart: stop start

stats:
	@docker stats

logs:
	@docker compose logs immich-server

workspace:
	@docker compose exec immich-server /bin/bash

clean:
	@docker compose down -v --remove-orphans
