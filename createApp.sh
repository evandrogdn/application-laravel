#!/bin/bash
docker run -it --rm -v $(pwd):app/ evandrogdn/docker-laravel composer create-project laravel/laravel app --ignore-plaform-reqs