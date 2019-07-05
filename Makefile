.PHONY: install
install:
	pip3 install --quiet -r requirements.txt -r requirements-dev.txt

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
	python3 -m isort packed tests --recursive --check-only

.PHONY: check-style
check-style:
	python3 -m flake8 packed tests

.PHONY: lint
lint: check-types check-style check-imports

.PHONY: all
all: install lint test

.PHONY: test-in-docker
test-in-docker:
	docker run -v `pwd`:/tmp -w /tmp python:$(or $(PYTHON_VERSION),3.6) make install test

.PHONY: all-in-docker
all-in-docker:
	docker run -v `pwd`:/tmp -w /tmp python:$(or $(PYTHON_VERSION),3.6) make all
