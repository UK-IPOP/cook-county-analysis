format:
	@poetry run echo "Running black formatter..."
	@poetry run black src/geocoding
	@poetry run echo "Running isort formatter..."
	@poetry run isort src/geocoding

lint:
	@poetry run echo "Running flake8 linter..."
	@poetry run flake8 src/geocoding --max-line-length=89

test: # needed?
	@poetry run echo "Running pytest..."
	@poetry run pytest tests --color=yes

cleanup:
	@bash ./scripts/cleanup.sh
