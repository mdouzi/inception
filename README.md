# Inception

Inception is a system administration and DevOps project from the 42 curriculum. The goal is to set up a fully functional Docker-based infrastructure with multiple services running in isolated containers, ensuring scalability, security, and automation.

![Project Screenshot](screenshot.png)

## Features
- Uses Docker and Docker Compose for container orchestration.
- Includes Nginx as a reverse proxy with SSL.
- Deploys WordPress with MariaDB as the database.
- Implements Redis for caching.
- Uses a dedicated FTP server for file transfers.
- Runs a monitoring stack with Prometheus and Grafana.
- Ensures security through proper user privileges and SSL certificates.

## Technologies Used
- **Containerization**: Docker, Docker Compose
- **Web Server**: Nginx
- **Database**: MariaDB
- **Caching**: Redis
- **Monitoring**: Prometheus, Grafana
- **Security**: SSL/TLS, User Privileges

## Installation & Usage
Clone the repository:
```sh
git clone https://github.com/yourusername/inception.git
cd inception
```
Build and start the containers:
```sh
docker-compose up --build -d
```
Check running services:
```sh
docker ps
```
Access the application in your browser:
```sh
https://localhost
```

## Authors
- Mohamed Douzi

## License
This project is part of the 42 curriculum and follows its academic integrity rules.

