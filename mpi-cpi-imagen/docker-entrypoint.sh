#!/bin/bash
service ssh restart
exec "$@"
exec tail -f /dev/null