# Dockerizing Python and MongoDB
# Based on ubuntu:latest, installs MongoDB following the instructions from:
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
# INSTRUCTIONS:
# - Create the container:
#   > docker build -t ubuntu_pymongo .
# - Create a folder to share your project in your host with the container. Ex: ~/shared
# - Run the next command (need the route of the created shared folder), this command access to the bash of container:
#   > docker run -v /c/Users/Jhonny/Documents/vm_share/mongoDB/shared:/data/code -t -i -p 27019:27017 ubuntu_pymongo
# - To open another bash console run the command: 
#   > docker exec -it <id_contenedor> bash
# - Run the mongo database:
#   > mongod
# - To connect compass or another gui with mongo use the IP of docker: 192.168.99.100 and the port 27019, or another that you indicate in the command


FROM       ubuntu:16.04
MAINTAINER Docker


# Copy the current directory contents into the container at /app
ADD . /app

# Set the working directory to /app
WORKDIR /app

# Run app.py when the container launches
ENTRYPOINT ["python","index.py"]

# Installation:

#RUN apt-get update && apt-get install python3
#RUN apt-get install -y python-setuptools
#RUN apt-get install -y python-pip

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip
RUN apt-get install -y nano
RUN apt-get install -y telnet
RUN apt-get install -y vim

RUN pip install flask-wtf
RUN pip install flask-bootstrap
RUN pip install flask-pymongo
RUN pip install flask-mail
RUN pip install requests


# Install any needed packages specified in requirements.txt
#RUN pip install --upgrade pip
#RUN pip install -r requirements.txt

# Make port 4000 available to the world outside this container
EXPOSE 4000