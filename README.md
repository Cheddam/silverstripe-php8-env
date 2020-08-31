# Silverstripe in PHP 8

This project consists of:

- A `Dockerfile` that generates a PHP 8 + Apache image with necessary extensions built and enabled
- A `docker-compose.yml` file that spins up the PHP container alongside a MySQL container and links them together
- A Silverstripe CMS 4.x-dev build that points to necessary forks for PHP 8 support whilst it's in development

To run the environment:

```
cd build
composer install
cd ..
docker-compose up -d --build
```

The web server will be accessible at http://localhost:8090. To SSH in and run PHPUnit:

```
docker exec -it silverstripe-php8-env_web_1 /bin/bash
```

[Xdebug 3](https://3.xdebug.org/docs/upgrade_guide) is also present and enabled. This works with web requests, but not with CLI commands so far. You may need to disable it to successfully run `/dev/build` ;)

