#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --no-input --clear

gunicorn --reload myproject.wsgi:application -b 0.0.0.0:8000

exec "$@"



# Create migrations based on django models
#python manage.py makemigrations

# Migrate created migrations to database
#python manage.py migrate

# Copy all static files to specific directory for nginx
#python manage.py collectstatic --no-input --clear

# Start gunicorn server at port 8000 and keep an eye for app code changes
# If changes occur, kill worker and start a new one
#gunicorn --reload myproject.wsgi:application -b 0.0.0.0:8000