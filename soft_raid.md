    https://blog.csdn.net/huryer/article/details/85130218    

    安装mdadm工具
    yum install mdadm -y

    创建soft raid5
    mdadm -C /dev/md0 -ayes -l5 -n7 /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh

    lsblk 可以看到所有device都映射到了/dev/md0上
    cat /proc/mdstat 可以查看md0状态
    mdadm -D /dev/md0  查看md0信息

    mdadm -Dsv > /etc/mdadm.conf  写入配置文件，系统启动时会自动加载软raid

    后续格式化后，可以加入/etc/fstab 开机自动挂载软raid设备到目录
    /dev/md0  /export  xfs  defaults 0 0