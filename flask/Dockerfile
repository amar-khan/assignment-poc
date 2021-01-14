FROM python:3.7-alpine
MAINTAINER Amar Khan "amarkotasky@gmail.com"

ENV FLASK_DEBUG True

RUN mkdir -p /home/bituser

RUN addgroup -S bituser && adduser -S bituser -G bituser

ENV HOME=/home/bituser
ENV APP_HOME=/home/bituser/app

COPY . $HOME

WORKDIR $APP_HOME

RUN chown -R bituser:bituser $APP_HOME
RUN chown -R bituser:bituser /var/log

USER bituser

RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["src/app.py"]