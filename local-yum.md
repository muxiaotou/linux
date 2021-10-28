# 快速配置一个本地yum源

    centos7：
    
    1.mount -t iso9660 -o loop /home/CentOS-7-x86_64-DVD-1804.iso /mnt/
    2.[root@localhost ~]# cat /etc/yum.repos.d/local.repo 
        [local-yum]
        name=local-yum
        baseurl=file:///mnt/
        enabled=1
        gpgcheck=0
    3.yum clean all
    
    
    centos8：【yum 实际指向了dnf】
    1.mount -t iso9660 -o loop /home/CentOS-7-x86_64-DVD-1804.iso /mnt/
    2.[root@localhost ~]# cat /etc/yum.repos.d/local.repo
        [BaseOS]
        name=CentOS-BaseOS
        baseurl=file:///mnt/BaseOS
        gpgcheck=0
        enabled=1
        
        [APP]
        name=CentOS-APP
        baseurl=file:///mnt/AppStream
        gpgcheck=0
        enabled=1
    3.yum clean all

