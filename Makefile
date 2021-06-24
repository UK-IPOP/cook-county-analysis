format:
	@poetry run echo "Running black formatter..."
	@poetry run black src/geocoding
	@poetry run black scripts/
	@poetry run echo "Running isort formatter..."
	@poetry run isort src/geocoding
	@poetry run isort scripts/

lint:
	@poetry run echo "Running flake8 linter..."
	@poetry run flake8 src/geocoding --max-line-length=89
	@poetry run flake8 scripts --max-line-length=89

test: # needed?
	@poetry run echo "Running pytest..."
	@poetry run pytest tests --color=yes

pipeline:
	@echo "Starting pipeline..."
	@poetry run python scripts/land_use_runner.py
	@poetry run python scripts/pharmacy_runner.py
	@poetry run python scripts/case_archive_runner.py
	@poetry run python scripts/distance_runner.py
	@echo "Pipeline complete."

