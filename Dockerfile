FROM python:2

WORKDIR /app

ADD pkglist .
RUN apt-get update \
 && apt-get install -y $(cat pkglist)

ADD requirements-ckan.txt .
RUN pip install -r requirements-ckan.txt

ADD requirements.txt .
RUN pip install -r requirements.txt

ADD requirements-plugins.txt .
RUN pip install -r requirements-plugins.txt

ADD Procfile who.ini ckan.ini .

RUN useradd --system --uid 900 --shell /bin/false ckan

USER ckan
EXPOSE 5000