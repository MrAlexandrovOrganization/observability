DOCKER_COMPOSE = docker compose

include .env
export

TEMPLATE_VARS = $${TELEGRAM_BOT_TOKEN} $${TELEGRAM_CHAT_ID}

init:
	mkdir -p $(MONITORING_DATA_DIR)/prometheus-targets
	mkdir -p $(MONITORING_DATA_DIR)/grafana-dashboards

render:
	@find grafana/provisioning -name '*.tpl.yml' | while read tpl; do \
		out="$${tpl%.tpl.yml}.yml"; \
		envsubst '$(TEMPLATE_VARS)' < "$$tpl" > "$$out"; \
		echo "rendered $$out"; \
	done

up: init render
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs -f

.PHONY: init render up down logs
