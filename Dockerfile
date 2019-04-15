FROM amazonlinux:latest
RUN yum install -y tar xz java-1.8.0-openjdk \
    git gcc-c++ make openssl-devel wget
RUN git clone https://github.com/nodejs/node.git
RUN cd ./node/ &&  ls -l &&  git checkout v8.10.0 &&  git checkout v8.10.0 &&  ./configure &&  make &&  make install
RUN npm -v
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN tar -xvf ./wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
RUN cd /wkhtmltox/bin && cp wkhtmltopdf  /usr/bin/wkhtmltopdf
RUN rm -r  ./wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

ENV PATH="/usr/bin/wkhtmltopdf:${PATH}"
RUN echo "$PATH"

RUN npm install -g node-wkhtmltopdf serverless@1.40.0
RUN serverless -v

ENV LDFLAGS=-Wl,-rpath=/var/task/
RUN yum install cairo cairo-devel libjpeg8-devel libjpeg-turbo-devel automake gcc kernel-devel   -y
ENV PKG_CONFIG_PATH='/usr/local/lib/pkgconfig'
ENV LD_LIBRARY_PATH='/usr/local/lib':$LD_LIBRARY_PATH



RUN npm install -g node-gyp@8.10.2
RUN npm install -g canvas@2.4.1
RUN npm install -g fabric@2.7.0

RUN cd /usr/local/lib/node_modules/canvas && node-gyp rebuild
