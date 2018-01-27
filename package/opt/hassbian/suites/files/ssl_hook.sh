#!/usr/bin/env bash
set -e
set -u
set -o pipefail

domain="myhome"
token="your-duckdns-token"

case "$1" in
    "deploy_challenge")
        curl "https://www.duckdns.org/update?domains=$domain&token=$token&txt=$4"
        echo
        ;;
    "clean_challenge")
        curl "https://www.duckdns.org/update?domains=$domain&token=$token&txt=removed&clear=true"
        echo
        ;;
    "deploy_cert")
        ;;
    "unchanged_cert")
        ;;
    "startup_hook")
        ;;
    "exit_hook")
        ;;
    *)
        echo Unknown hook "${1}"
        exit 0
        ;;
esac
