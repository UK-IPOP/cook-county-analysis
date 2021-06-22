format:
	@echo "Running black formatter..."
	@black src/geocoding
	@echo "Running isort formatter..."
	@isort src/geocoding

lint:
	@echo "Running flake8 linter..."
	@flake8 src/geocoding --max-line-length=89

test: # needed?
	@echo "Running pytest..."
	@pytest tests --color=yes
