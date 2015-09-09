#!/bin/bash

# First, make sure that cgroups are mounted correctly.
CGROUP=/sys/fs/cgroup

[ -d $CGROUP ] ||
  mkdir $CGROUP

mountpoint -q $CGROUP ||
  mount -n -t tmpfs -o uid=0,gid=0,mode=0755 cgroup $CGROUP || {
    echo "Could not make a tmpfs mount. Did you use -privileged?"
    exit 1
  }

# Mount the cgroup hierarchies exactly as they are in the parent system.
for SUBSYS in $(cut -d: -f2 /proc/1/cgroup)
do
  [ -d $CGROUP/$SUBSYS ] || mkdir $CGROUP/$SUBSYS
  mountpoint -q $CGROUP/$SUBSYS ||
    mount -n -t cgroup -o $SUBSYS cgroup $CGROUP/$SUBSYS
done

# Now, close extraneous file descriptors.
pushd /proc/self/fd
for FD in *
do
  case "$FD" in
  # Keep stdin/stdout/stderr
  [012])
    ;;
  # Nuke everything else
  *)
    eval exec "$FD>&-"
    ;;
  esac
done
popd

docker daemon &
exec java -jar /opt/jenkins/jenkins.war
