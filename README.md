# Node Docker Image

This image is for a development environment with node.

## Usage

Your project must contain a Node application and an appropriate configuration
(example with docker-compose):

```yml
version: '3.6'
services:
  front:
    image: lets/docker-node:0.0.1
    container_name: some-name
    command: npm run dev
    env_file:
      - .env
    volumes:
      - .:/app
    ports:
      - 3000:8000
    networks:
      - net
    tty: true
    stdin_open: true
```

Note that it requires app code mounted at `/app/src`.
