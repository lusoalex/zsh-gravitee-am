# Gravitee Access Management custom zsh plugin

This is a custom zsh plugin to enable `graivtee-am` command from everywhere, as a wrapper of gravitee-am Makefile.  
_It also add a few command such as plugin `gravitee-am plugin`._  

## How to install

In you `~/.zshrc` you need to export GIO_AM_HOME with as value the place where is located your repository.  

```BASH
# Export required by zsh-gravitee-am plugin
export GIO_AM_HOME="$HOME/github/graviteeio/graviteeio-access-management"

plugins=(
  git
  docker
  zsh-gravitee-am
)
```
Once installed, just type `gravitee-am help` to get more details.

## Few examples

```BASH
# Display help command
gravitee-am help

# Build plugin in current folder and update only the gateway
gravitee-am plugin gateway

# Build plugin in current folder and update both the gateway and management-api
gravitee-am plugin

# Build all plugins and update both the gateway and management-api
gravitee-am plugins

# Build all and run docker-compose
gravitee-am gravitee
```