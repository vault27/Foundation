## dg_custom.sh

This script adds/deletes/lists IPs in datagroup using API.
It sends commands to a main node and then syncs cluster.
Plus it checks that all commands were successfull.
Be careful: you have to specify mask, when you delete IPs.
Script is focused on that there are 5 regions, where F5 BIG-IP is installed, you have to choose the region to configure.

## dg_all.sh

This script adds/deletes IPs in datagroup using API to many BIG-IP simulteniously.
It sends commands to a main node and then syncs cluster.
Plus it checks that all commands were successfull.
Be careful: you have to specify mask, when you delete IPs.
You can add any amount of BIG-IPs.
