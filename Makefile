
format:
	poetry run black scripts/
	poetry run black src/geocoding/
	poetry run isort scripts/
	poetry run isort src/geocoding/

lint:
	poetry run flake8 scripts/
	poetry run flake8 src/geocoding/

test:
	poetry run coverage run -m pytest tests/ --color=yes