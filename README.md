# docker-zabbix-agent2-smartctl
## Description
This is a docker image for zabbix-agent2 including zbx-smartctl.

While the base image version is not hard-coded, the zbx-smartctl version is currently set to _1.5_ but can be overridden using the ZBX_SMARTCTL_VERSION argument.

The sg3_utils and nvme-cli packages are included for full hardware RAID and NVMe device support.

## Example docker-compose.yml
```
version: "2.4"

services:
  zabbix-agent2:
    build: ../../images/zabbix-agent2-smartctl
    container_name: zabbix-agent2
    environment:
      ZBX_HOSTNAME: "server"
    network_mode: host
    privileged: true
```
