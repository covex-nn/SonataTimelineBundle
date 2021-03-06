# DO NOT EDIT THIS FILE!
#
# It's auto-generated by sonata-project/dev-kit package.

all:
	@echo "Please choose a task."
.PHONY: all

lint: lint-composer lint-yaml lint-composer lint-xml lint-php
.PHONY: lint

lint-composer:
	composer validate
.PHONY: lint-composer

lint-yaml:
	find . -name '*.yml' -not -path './vendor/*' -not -path './src/Resources/public/vendor/*' | xargs yaml-lint

.PHONY: lint-yaml

lint-xml:
	find . \( -name '*.xml' -or -name '*.xliff' \) \
		-not -path './vendor/*' \
		-not -path './src/Resources/public/vendor/*' \
		| while read xmlFile; \
	do \
		XMLLINT_INDENT='    ' xmllint --encode UTF-8 --format "$$xmlFile"|diff - "$$xmlFile"; \
		if [ $$? -ne 0 ] ;then exit 1; fi; \
	done

.PHONY: lint-xml

lint-php:
	php-cs-fixer fix --ansi --verbose --diff --dry-run
.PHONY: lint-php

cs-fix: cs-fix-php cs-fix-xml
.PHONY: cs-fix

cs-fix-php:
	php-cs-fixer fix --verbose
.PHONY: cs-fix-php

cs-fix-xml:
	find . \( -name '*.xml' -or -name '*.xliff' \) \
		-not -path './vendor/*' \
		-not -path './src/Resources/public/vendor/*' \
		| while read xmlFile; \
	do \
		XMLLINT_INDENT='    ' xmllint --encode UTF-8 --format "$$xmlFile" --output "$$xmlFile"; \
	done
.PHONY: cs-fix-xml

test:
	phpunit -c phpunit.xml.dist --coverage-clover build/logs/clover.xml
.PHONY: test

docs:
	cd docs && sphinx-build -W -b html -d _build/doctrees . _build/html
.PHONY: docs
