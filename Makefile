# Makefile
SHELL := /bin/bash

.PHONY: help
help:
	@echo "Commands:"
	@echo "style   : runs style formatting."
	@echo "clean   : cleans all unecessary files."

# Styling
.PHONY: install-requirements
install-requirements:
	python -m pip install -r requirements.txt

# Styling
.PHONY: style
style:
	black .
	flake8
	isort .

# Dead code
.PHONY: dead-code
dead-code:
	vulture

# Cleaning
.PHONY: clean
clean: style dead-code
	find . -type f -name "*.DS_Store" -ls -delete
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
	find . | grep -E ".pytest_cache" | xargs rm -rf
	find . | grep -E ".ipynb_checkpoints" | xargs rm -rf
	find . | grep -E ".virtual_documents" | xargs rm -rf
	rm -f .coverage
