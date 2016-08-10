# Build the image to be used for this job.
IMAGE=$(sudo docker build . | tail -1 | awk '{ print $NF }')

# Build the directory to be mounted into Docker.
MNT="$WORKSPACE/.."

# Execute the build inside Docker.
CONTAINER=$(sudo docker run -d -v $MNT:/opt/project/ $IMAGE /bin/bash -c 'cd /opt/project/workspace && rake spec')

# Attach to the container so that we can see the output.
sudo docker attach $CONTAINER

# Get its exit code as soon as the container stops.
RC=$(sudo docker wait $CONTAINER)

# Delete the container we've just used.
sudo docker rm $CONTAINER

# Exit with the same value as that with which the process exited.
exit $RC
