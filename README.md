# RTMP/HLS Adaptive Streaming w/ NGINX

* Install Docker
* run `make && make run` to create docker image
* Create a RTMP stream
  - source: `rtmp://localhost:1935/live`,
  - key: `nginx`
* Watch it @ http://dailymotion.github.io/hls.js/demo/?src=http%3A%2F%2Flocalhost%3A8080%2Fshow%2Fnginx.m3u8
