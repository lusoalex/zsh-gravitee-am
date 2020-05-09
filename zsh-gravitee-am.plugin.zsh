# Plugin require to know where is gravitee AM folder located, it must be set into your ~/.zshrc
[[ -z "$GIO_AM_HOME" ]] && echo "\$GIO_AM_HOME is not set"

_update_graviteeam_plugin() {
  echo "Building local folder artifact skipping tests"
  mvn -DskipTests install
  if [ -z "$2" ]
    then
      echo "No additional argument supplied, will copy plugin to gateway & management-api"
      cp target/gravitee-*.zip "$GIO_AM_HOME/.working/gateway/plugins"
      cp target/gravitee-*.zip "$GIO_AM_HOME/.working/management-api/plugins"
    else
      echo "Will deploy to $2 folder"
      cp target/gravitee-*.zip "$GIO_AM_HOME/.working/$2/plugins"
  fi
}

# Wrap graviteeam function to call Makefile localted at the $GIO_AM_HOME folder
gravitee-am() {
  # Override plugin function to use custom script, else simply call the makefile
  case $1 in
    'help')
      (cd $GIO_AM_HOME && make help)
      printf "\033[36m%-20s\033[0m %s\n" "plugins" "Build and copy plugins to Gateway and Management API .working folder (-Dgravitee.home=.working/(gateway|management-api)"
      printf "\033[36m%-20s\033[0m %s\n" "plugin" "Build Single (local folder) .zip plugin and copy it to Gateway & Management API"
      ;;
    'plugins')
      (cd $GIO_AM_HOME && make OPTIONS=-DskipTests install)
      ;;
    'plugin')
      _update_graviteeam_plugin ${@:1}
      ;;
    *)
      (cd $GIO_AM_HOME && make ${@:1})
      ;;
  esac
}

# Make sure we always return good exit code
# We can't `return 0` because that breaks antigen
true