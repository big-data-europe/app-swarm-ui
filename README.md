# swarm-ui

Friendly web interface for swarm with access control

*NOTE: use of SwarmUI on a multi-node Swarm cluster requires shared volumes, like NFS.  Specific  documentation on setting this up will follow in the coming weeks.*

## How to

Clone this project, and launch docker-compose yaml.

    git clone https://github.com/big-data-europe/app-swarm-ui.git
    cd app-swarm-ui
    docker-compose up

Point your browser on `http://localhost:88` to use the interface.

## Planned features

- User management
- Access control
- Monitoring and launching pipelines
- Scaling pipelines
