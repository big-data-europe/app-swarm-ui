# swarm-ui

Friendly web interface for swarm with access control

## How to

Clone this project, and launch docker-compose yaml.

    git clone https://github.com/big-data-europe/app-swarm-ui.git
    cd app-swarm-ui
    docker-compose up

The API is now up-and-running.  For now, you should launch the frontend separately.  Clone the ember-swarm-ui-frontend repository, and boot it up.

    git clone https://github.com/big-data-europe/ember-swarm-ui-frontend.git
    cd ember-swarm-ui-frontend
    npm install; bower install; ember serve --proxy http://localhost:88/

Visit your browser on `http://localhost:4200` to use the interface.

## Planned features

- User management
- Access control
- Monitoring and launching pipelines
- Scaling pipelines
