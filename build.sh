#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "./build.sh <Path to UMDS tarball> <Base image type: use \"photon4\" here>" >&2
    exit 1
else
    TARBALL=$1
    BASEIMAGE=$2
fi

if [ ! -f "$TARBALL" ]; then
    echo "The specified $TARBALL does not exist." >&2
    exit 2
else
    UMDS_VER=$(echo $TARBALL | sed 's/.*VMware-UMDS-\([0-9]\.[0-9]\)\.[0-9].*.tar.gz/\1/')
    UMDS_VERNUM=$(echo $UMDS_VER | sed 's/\.//')
    BUILDARGS="$BUILDARGS --build-arg umds_tarball=$TARBALL"
    BUILDARGS="$BUILDARGS --build-arg umds_download_cfg=./config/vsphere$UMDS_VERNUM.xml"
fi

if [ ! -x /usr/bin/podman ]; then
    echo "/usr/bin/podman is not executable or found."
fi

case $BASEIMAGE in
  photon4)
    CONTAINER_FILE=Containerfile.photon4
    ;;

  *)
    echo "Unsupported container base image type." >&2
    exit 3
    ;;
esac

echo localhost/vmware-umds:$UMDS_VER-$BASEIMAGE > .lastumdsimage
podman build $BUILDARGS --file $CONTAINER_FILE --squash-all --tag vmware-umds:$UMDS_VER-$BASEIMAGE
