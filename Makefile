format:
	@echo "Running black formatter..."
	@poetry run black src/geocoding
	@poetry run black scripts/
	@echo "Running isort formatter..."
	@poetry run isort src/geocoding
	@poetry run isort scripts/

lint:
	@echo "Running flake8 linter..."
	@poetry run flake8 src/geocoding scripts --max-line-length=89

test: # needed?
	@echo "Running pytest..."
	@poetry run pytest tests --color=yes

docs:
	@poetry run mkdocs build

docs-deploy:
	@poetry run mkdocs gh-deploy

pipeline:
	@echo "Starting pipeline..."
	@bash scripts/download_landuse_shapefiles.sh
	@poetry run python scripts/land_use_runner.py
	@poetry run python scripts/pharmacy_runner.py
	@poetry run python scripts/case_archive_runner.py
	@poetry run python scripts/distance_runner.py
	@poetry run python scripts/spatial_join_runner.py
	@Rscript scripts/drug_detection.R
	@poetry run python scripts/merge_runner.py
	@bash scripts/cleanup.sh
	@echo "Pipeline complete."
