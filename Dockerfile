FROM zabbix/zabbix-agent2:latest

USER 0

ARG ZBX_SMARTCTL_SOURCES=https://github.com/v-zhuravlev/zbx-smartctl.git
ARG ZBX_SMARTCTL_VERSION=v1.5

RUN set -eux \
 && apk add --no-cache --clean-protected \
    git \
    smartmontools \
    sg3_utils \
    nvme-cli \
    sudo \
    perl \
 && git clone ${ZBX_SMARTCTL_SOURCES} --branch ${ZBX_SMARTCTL_VERSION} --depth 1 --single-branch /tmp/zbx-smartctl-${ZBX_SMARTCTL_VERSION} \
 && mv /tmp/zbx-smartctl-${ZBX_SMARTCTL_VERSION}/sudoers_zabbix_smartctl /etc/sudoers.d \
 && mv /tmp/zbx-smartctl-${ZBX_SMARTCTL_VERSION}/zabbix_smartctl.conf /etc/zabbix/zabbix_agentd.d \
 && mkdir /etc/zabbix/scripts \
 && mv /tmp/zbx-smartctl-${ZBX_SMARTCTL_VERSION}/discovery-scripts/nix/smartctl-disks-discovery.pl /etc/zabbix/scripts \
 && chown zabbix:zabbix /etc/zabbix/scripts/smartctl-disks-discovery.pl \
 && chmod u+x /etc/zabbix/scripts/smartctl-disks-discovery.pl \
 && rm -rf /tmp/zbx-smartctl-${ZBX_SMARTCTL_VERSION} \
 && apk del --purge --no-network \
    git && \
 && rm -rf /var/cache/apk/*

USER 1997
