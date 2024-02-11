#!/bin/bash

# flush various DNS caches
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
