#!/usr/bin/env bashio
set -e
cp /gui_template.html /data/gui_template.html
bashio::log.info "Starting gmusicproxy..."
ingress_enabled=$(bashio::addon.ingress)
FILE=/etc/resolv.conf
if [ ! -f "/data/mobileclient.cred" ]; then
    bashio::log.info "No credentials file found, sleeping for 3600 sec, waiting for configure..."
    sleep 3600
    bashio::log.info "Not configured exiting..."
else
  if [[ $ingress_enabled == "true" ]]; then
    /GMusicProxy --host "$(bashio::addon.ingress_entry)" -P $(bashio::config 'port')
  else
    /GMusicProxy --host $(bashio::config 'url') -P $(bashio::config 'port')
  fi
fi