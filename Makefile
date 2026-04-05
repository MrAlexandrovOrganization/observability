DOCKER_COMPOSE = docker compose

include .env
export

init:
	mkdir -p $(MONITORING_DATA_DIR)/prometheus-targets
	mkdir -p $(MONITORING_DATA_DIR)/grafana-dashboards

up: init
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs -f

.PHONY: init up down logs
