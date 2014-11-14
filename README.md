# docker-ruby

This repository contains the Dockerfile for Lita.io's public Ruby image: [litaio/ruby](https://registry.hub.docker.com/u/litaio/ruby/)

## Usage

This image has no default command, so it must be specified when running a container. For an interactive Bash shell:

``` bash
docker run -it litaio/ruby bash
```

For an interactive Ruby REPL:

``` bash
docker run -it litaio/ruby irb
```

## License

[MIT](http://opensource.org/licenses/MIT)
