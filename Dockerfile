FROM python:3.8

LABEL Author="manar"
ARG ENV

ENV PYTHONBUFFERED 1
ENV PYTHONPATH $PYTHONPATH:/code:/code/config 
ENV DJANGO_SETTINGS_MODULE config.settings 

# set the working directory in the container
WORKDIR /code

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY . .

# command to run on container start
CMD [ "python", "./server.py" ]

RUN chmod +x ./entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]