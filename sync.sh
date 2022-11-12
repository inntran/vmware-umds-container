#!/bin/bash

CTRID=$(podman run --rm --detach --security-opt=label=disable \
--volume /srv/mirror/vmware-updates:/var/lib/vmware-umds `cat .lastumdsimage`)
