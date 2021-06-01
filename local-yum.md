# 快速配置一个本地yum源
    1.mount -t iso9660 -o loop /home/CentOS-7-x86_64-DVD-1804.iso /mnt/
    2.[root@localhost ~]# cat /etc/yum.repos.d/local.repo 
        [local-yum]
        name=local-yum
        baseurl=file:///mnt/
        enabled=1
        gpgcheck=0
    3.yum clean all

