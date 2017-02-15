default :
	docker build -t nginx-rtmp .

run :
	docker run -p 1935:1935 -p 8080:80 nginx-rtmp
