FROM ubuntu as base

RUN apt-get update && apt-get install -y \
    cifs-utils \
    nodejs \
    npm \
    samba

FROM base

RUN mkdir /mnt/test
RUN mkdir /etc/smbcredentials
RUN bash -c 'echo "username=STORAGEACCOUNTNAME" >> /etc/smbcredentials/mgrpremiumtest.cred'
RUN bash -c 'echo "password=KEY" >> /etc/smbcredentials/mgrpremiumtest.cred'
RUN chmod 600 /etc/smbcredentials/mgrpremiumtest.cred


RUN useradd otter
RUN (echo "ottersrule"; echo "ottersrule") | smbpasswd -s -a otter

WORKDIR /etc/samba

COPY smb.conf ./

RUN service smbd restart

WORKDIR /app/

COPY package*.json ./

RUN npm install --production

COPY app.js ./
COPY start.sh ./

EXPOSE 137-138/udp 139/tcp 445/tcp

CMD ["/app/start.sh"]
