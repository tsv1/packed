.PHONY: install
install:
	pip3 install -r requirements.txt -r requirements-dev.txt

.PHONY: build
build:
	python3 setup.py sdist bdist_wheel

.PHONY: test
test:
	python3 -m pytest -s

.PHONY: coverage
coverage:
	python3 -m pytest --cov --cov-report=term \
							--cov-report=xml:$(or $(COV_REPORT_DEST),coverage.xml)

.PHONY: check-types
check-types:
	python3 -m mypy packed --strict

.PHONY: check-imports
check-imports:
	python3 -m isort --recursive --check-only

.PHONY: check-style
check-style:
	python3 -m flake8

.PHONY: lint
lint: check-types check-style check-imports

.PHONY: all
all: install lint test
