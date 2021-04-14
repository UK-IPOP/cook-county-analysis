FROM python:3.9-alpine

WORKDIR /code

# Copy in the config files:
COPY requirements.txt ./

# Install poetry:
RUN pip install -r requirements.txt

COPY ./app /code/app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
