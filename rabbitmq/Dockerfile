ARG RABBITMQ_VERSION=latest
FROM rabbitmq:${RABBITMQ_VERSION}-alpine

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL RABBITMQ_VERSION=${RABBITMQ_VERSION}

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone

##############################
# Update system with bug-fixed
##############################
RUN apk update && \
    apk upgrade

##############################
# Plugin setting
##############################

# Management plugin <https://www.rabbitmq.com/management.html>
ARG RABBITMQ_PLUGIN_ENABLE_MANAGEMENT=false

RUN if [ ${RABBITMQ_PLUGIN_ENABLE_MANAGEMENT} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_management \
;fi

# Federation plugin <https://www.rabbitmq.com/federation.html>
ARG RABBITMQ_PLUGIN_ENABLE_FEDERATION=false
ARG RABBITMQ_PLUGIN_ENABLE_FEDERATION_MANAGEMENT=false

RUN if [ ${RABBITMQ_PLUGIN_ENABLE_FEDERATION} = true ]; then\
    rabbitmq-plugins enable --offline rabbitmq_federation && \
    # enable management function
    if [ ${RABBITMQ_PLUGIN_ENABLE_FEDERATION_MANAGEMENT} = true ]; then \
        rabbitmq-plugins enable --offline rabbitmq_federation_management \
    ;fi \
;fi

# Shovel plugin <https://www.rabbitmq.com/shovel.html>
ARG RABBITMQ_PLUGIN_ENABLE_SHOVEL=false

RUN if [ ${RABBITMQ_PLUGIN_ENABLE_SHOVEL} = true ]; then \
rabbitmq-plugins enable --offline rabbitmq_shovel \
    ;fi
    
# Stomp plugin <https://www.rabbitmq.com/stomp.html>
ARG RABBITMQ_PLUGIN_ENABLE_STOMP=false
    
RUN if [ ${RABBITMQ_PLUGIN_ENABLE_STOMP} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_stomp \
;fi
    
# Web stomp (stomp over websockets) plugin <https://www.rabbitmq.com/web-stomp.html>
ARG RABBITMQ_PLUGIN_ENABLE_WEB_STOMP=false
    
RUN if [ ${RABBITMQ_PLUGIN_ENABLE_WEB_STOMP} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_web_stomp \
;fi
    
# Mqtt plugin <https://www.rabbitmq.com/mqtt.html>
ARG RABBITMQ_PLUGIN_ENABLE_MQTT=false
    
RUN if [ ${RABBITMQ_PLUGIN_ENABLE_MQTT} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_mqtt \
;fi
    
# Web mqtt (mqtt over websockets) plugin <https://www.rabbitmq.com/web-mqtt.html>
ARG RABBITMQ_PLUGIN_ENABLE_WEB_MQTT=false
    
RUN if [ ${RABBITMQ_PLUGIN_ENABLE_WEB_MQTT} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_web_mqtt \
;fi
    
# LDAP plugin <https://www.rabbitmq.com/ldap.html>
ARG RABBITMQ_PLUGIN_ENABLE_LDAP=false
    
RUN if [ ${RABBITMQ_PLUGIN_ENABLE_LDAP} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_auth_backend_ldap \
;fi
    
# Web dispatch (Configuring HTTP-based (web) ) plugin <https://www.rabbitmq.com/web-dispatch.html>
ARG RABBITMQ_PLUGIN_ENABLE_WEB_DISPATCH=false
    
RUN if [ ${RABBITMQ_PLUGIN_ENABLE_WEB_DISPATCH} = true ]; then \
    rabbitmq-plugins enable --offline rabbitmq_web_dispatch \
;fi
    
##############################
# Final step
##############################
    
RUN rm /var/cache/apk/* && \
    rm -rf /tmp/*
    
EXPOSE 1833 8883 4369 5671 5672 15671 15672 15674 15675 61613 61614