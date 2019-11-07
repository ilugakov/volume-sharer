FROM dperson/samba
MAINTAINER Igor Lugakov <ilugakov@gmail.com>

VOLUME ["/etc/samba"]

#Based on this, we now install docker inside this image
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add docker && \
    rm -rf /tmp/*

#This is needed to ensure smbd is running as root to access
#all the files in the volumes directory
ENV USERID=0 GROUPID=0

#Copy the volume-sharer file to bin
COPY volume-sharer.sh /usr/bin/

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["volume-sharer.sh"]
