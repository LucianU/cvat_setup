# CVAT Setup
This project gives you a running instance of CVAT [Computer Vision Annotation Tool]. It automates all the steps needed for the setup.

# Setup
* In order to be able to run this project, you need to install:
  - docker
  - docker-compose
  - python
  - git
* Create a file `config.sh` from `config.sh.orig` and fill in the variables found there:
  - `CVAT_TARGET_HOST`: the IP or host of the target machine; if the SSH port is not 22, you need to specify it like "127.0.0.1:2222"
  - `CVAT_TARGET_USER`: a user that can ssh into the target machine
  - `CVAT_SSH_PRIVATE_KEY`: the path to the private key
* Now run the `setup.sh` script:

      ./setup.sh

# Usage
* Run the `run.sh` script
* You should now have a running instance of CVAT on the host you specified.
* Now create a superuser in CVAT. SSH into the remote machine and run:

      docker exec -it cvat bash -ic 'python3 ~/manage.py createsuperuser'
