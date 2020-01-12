FROM python:alpine3.7

WORKDIR /app

COPY requirements.txt /app

RUN pip install -r requirements.txt

COPY app.py /app

EXPOSE 3000

CMD ["gunicorn", "-b", "0.0.0.0:3000", "app"]
