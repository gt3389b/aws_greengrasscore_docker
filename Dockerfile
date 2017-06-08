FROM ubuntu

RUN apt-get update && apt-get install -y sqlite3 wget lxc
RUN groupadd -r ggc_group 
RUN useradd -r ggc_user

RUN mkdir -p /opt/
COPY greengrass-linux-x86-64-1.0.0.tar.gz /opt/
#RUN chown -R ggc_user:ggc_user /opt
RUN cd /opt/ && tar -xvzf greengrass-linux-x86-64-1.0.0.tar.gz
RUN cd /opt/greengrass/configuration/certs/ && wget -q -O root-ca.pem https://www.symantec.com/content/en/us/enterprise/verisign/roots/VeriSign-Class%203-Public-Primary-Certification-Authority-G5.pem
COPY config.json /opt/greengrass/configuration/
COPY 9b99714b7b-certificate.pem.crt /opt/greengrass/configuration/certs/
COPY 9b99714b7b-private.pem.key /opt/greengrass/configuration/certs/

#RUN wget -q -O setup.sh https://raw.githubusercontent.com/tianon/cgroupfs-mount/master/cgroupfs-mount
#RUN chmod 755 ./setup.sh
#RUN bash ./setup.sh
#RUN lxc-checkconfig
#RUN lxc-create --name lxctest --template ubuntu -B overlayfs
CMD /opt/greengrass/greengrassd start
