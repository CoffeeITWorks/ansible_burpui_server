# Fedora local docker: https://success.docker.com/article/firewalld-problems-with-container-to-container-network-communications
# https://molecule.readthedocs.io/en/latest/examples.html#docker
docker run --rm -it --privileged=True \
    -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -w /tmp/$(basename "${PWD}") \
    retr0h/molecule:latest \
    sudo molecule test
