FROM python:3.12-slim

WORKDIR /app

RUN pip install --upgrade pip
COPY ./requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY ./app/ /app/

EXPOSE 80

CMD ["python", "app.py"]