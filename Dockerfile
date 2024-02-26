FROM python:3.11.6

WORKDIR /app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update
RUN yes | apt-get install sox ffmpeg libcairo2 libcairo2-dev pkg-config python3.11-dev

RUN python -m venv .venv

SHELL ["/bin/bash", "-c"]
RUN source .venv/bin/activate

COPY ./requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

COPY . . 

EXPOSE 8000

CMD python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:8000