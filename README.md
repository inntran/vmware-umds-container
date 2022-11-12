# VMware UMDS(Update Manager Download Service) in containers
Running VMware Update Manager Download Service in Linux containers

# References
* [Installing, Setting Up, and Using the Update Manager Download Service (VMware vSphere 8.0)
](https://docs.vmware.com/en/VMware-vSphere/8.0/vsphere-lifecycle-manager/GUID-AB1032CF-2C9A-44E5-94BA-216396F167F9.html)
* [Installing, Setting Up, and Using Update Manager Download Service (VMware vSphere 7.0)
](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere-lifecycle-manager.doc/GUID-AB1032CF-2C9A-44E5-94BA-216396F167F9.html)
* [Installing, Setting Up, and Using Update Manager Download Service (VMware vSphere 6.7)](https://docs.vmware.com/en/VMware-vSphere/6.7/com.vmware.vsphere.update_manager.doc/GUID-AB1032CF-2C9A-44E5-94BA-216396F167F9.html)

# Supported vSphere versions
* vSphere 8.0
* vSphere 7.0
* vSphere 6.7
Note: The UMDS version must match vCenter version.

# Usage
This project does NOT need root priviledges. We recommend you use rootless podman

1. Download vCenter ISO image
1. Extract UMDS tarball from "/umds" directory in the vCenter ISO image, example: 
    ```
    7z x VMware-VCSA-all-8.0.0-20519528.iso umds/
    ```
1. Execute `build.sh` to build the container, example:
    ```
    ./build.sh umds/VMware-UMDS-8.0.0.10000-10434837.tar.gz photon4
    ```
1. Create a directory on the host for VMware updates, and set the owner/group, example:
    ```
    sudo mkdir /srv/mirror/vmware-updates && sudo chown $(id -u):$(id -g) /srv/mirror/vmware-updates
    ```
1. Execute `sync.sh` to run the most recently built container to sync VMware updates, example:
    ```
    ./sync.sh
    ```
