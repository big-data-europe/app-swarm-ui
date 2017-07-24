# Swarm UI

Friendly web interface for swarm with access control

## Shared Config & Volume Using NFS

Use of SwarmUI on a multi-node Swarm cluster requires shared volumes, like NFS.

### Configuration Sharing

The configuration of every pipeline should be shared on all the nodes. *If this
step is not done, the containers may start with an empty configuration
directory.*

In order to share the configuration on all the repositories, we usually use
NFS. You can find an example of an Open Stack deployment using Terraform
[here](https://github.com/specialprivacy/openstack-terraform-bde-depoyment-script).

The principle is simple: there is one master node that share the directory
/app-swarm-ui using NFS. The other nodes will simply mount that directory at
the exact same location /app-swarm-ui.

While this works fine for any configuration directory, one should not use a
mount point on the host for data directories. It's best and faster to use
Docker volumes.

### Shared Volumes Using NFS

Specific  documentation on setting this up can be found
[here](https://github.com/big-data-europe/README/wiki/Setting-up-shared-NFS-volume-with-Convoy).

## How To

Clone this project, and launch docker-compose yaml.

    git clone https://github.com/big-data-europe/app-swarm-ui.git
    cd app-swarm-ui
    docker-compose up

Point your browser on `http://localhost:88` to use the interface.

## Planned Features

- User management
- Access control
- Monitoring and launching pipelines
- Scaling pipelines
