FROM python:alpine3.15

# -h Home directory
# -g GECOS field
# -G Group

RUN addgroup app && \
    adduser -G app -h /app -D -g "" app

USER app
WORKDIR /app

COPY . /app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD [ "python", "app.py" ]
