#!/bin/bash

# clean out ports that aren't marked as (active)
# note that any ports that still have dependencies on other active ports will
# cause this script to exit; just uninstall then reinstall the port with the
# dependency, and then re-run this script
port installed | grep -v "The following" | grep -v active \
    | xargs sudo port uninstall
