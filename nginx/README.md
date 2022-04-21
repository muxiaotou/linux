    install:
    vim /etc/yum.repos.d/nginx.repo 
    [nginx]
    name=nginx repo
    baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
    gpgcheck=0
    enabled=1

    stream {
        upstream ofs_monitor_ofs1{
            hash $remote_addr consistent;
            server 10.226.132.9:8410;
        }
        upstream ofs_monitor_ofs4{
            hash $remote_addr consistent;
            server 10.226.132.144:8410;
        }
        
        map $ssl_preread_server_name $ssl_server{
            ofs_monitor1.com ofs_monitor_ofs1;
            ofs_monitor4.com ofs_monitor_ofs4;
        }
        server {
            listen 8400 so_keepalive=on;
            proxy_connect_timeout 1s;
            tcp_nodelay on;
            proxy_timeout 360d;
            proxy_pass $ssl_server;
        }
    }

    http {
        upstream ofs_servers1{
            server 10.226.132.9:8411;
        }

        upstream ofs_servers4{
            server 10.226.132.144:8411;
        }

        server {
            listen 8401;
            server_name ofs_monitor1.com;
            location / {
                proxy_pass http://ofs_servers1;
            }
        }

        server {
            listen 8401;
            server_name ofs_monitor4.com;
            location / {
                proxy_pass http://ofs_servers4;
            }
        }
    }


    