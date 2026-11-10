FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

# 固定 Xray 版本,避免 latest 变化导致构建结果不可控(升级时改这里)
ARG XRAY_VERSION=v26.11.9

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl &&\
    wget -O temp.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip" &&\
    unzip temp.zip xray geoip.dat geosite.dat &&\
    mv xray v &&\
    rm -f temp.zip &&\
    chmod -v 755 v entrypoint.sh &&\
    echo 'ewogICAgImxvZyI6IHsKICAgICAgICAibG9nbGV2ZWwiOiAid2FybmluZyIsCiAgICAgICAgImFj\
Y2VzcyI6ICIvZGV2L251bGwiLAogICAgICAgICJlcnJvciI6ICIvZGV2L251bGwiCiAgICB9LAog\
ICAgImluYm91bmRzIjogWwogICAgICAgIHsKICAgICAgICAgICAgInBvcnQiOiAyMDAwMCwKICAg\
ICAgICAgICAgInByb3RvY29sIjogInZsZXNzIiwKICAgICAgICAgICAgImxpc3RlbiI6ICIxMjcu\
MC4wLjEiLAogICAgICAgICAgICAic2V0dGluZ3MiOiB7CiAgICAgICAgICAgICAgICAiY2xpZW50\
cyI6IFsKICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAgICJpZCI6\
ICJVVUlEIgogICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIF0sCiAgICAgICAg\
ICAgICAgICAiZGVjcnlwdGlvbiI6ICJub25lIgogICAgICAgICAgICB9LAogICAgICAgICAgICAi\
c3RyZWFtU2V0dGluZ3MiOiB7CiAgICAgICAgICAgICAgICAibmV0d29yayI6ICJ4aHR0cCIsCiAg\
ICAgICAgICAgICAgICAieGh0dHBTZXR0aW5ncyI6IHsKICAgICAgICAgICAgICAgICAgICAicGF0\
aCI6ICJWTEVTU19QQVRIIgogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAgICAg\
fQogICAgXSwKICAgICJvdXRib3VuZHMiOiBbCiAgICAgICAgewogICAgICAgICAgICAicHJvdG9j\
b2wiOiAiZnJlZWRvbSIsCiAgICAgICAgICAgICJzZXR0aW5ncyI6IHt9CiAgICAgICAgfQogICAg\
XSwKICAgICJkbnMiOiB7CiAgICAgICAgInNlcnZlcnMiOiBbCiAgICAgICAgICAgICI4LjguOC44\
IiwKICAgICAgICAgICAgIjguOC40LjQiLAogICAgICAgICAgICAibG9jYWxob3N0IgogICAgICAg\
IF0KICAgIH0KfQo=' > config

ENTRYPOINT [ "./entrypoint.sh" ]