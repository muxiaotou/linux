
    1）通过lscpu查看cpu的物理及逻辑核数，其中socket指代物理cpu个数，core per socket指代每个cpu上物理cpu核数，Threads per core指代每个物理核两个线程(可以理解一个物理核虚出2个逻辑核)
    2）查看cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list   0,16，表示编号为0和16的逻辑核归属同一个物理核，绑定是尽量避开0和16同时绑定
    3）修改grub，隔离核，不让其他的任务和中断调度到这个核上
        vim  /etc/default/grub
        修改
        GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0 isolcpus=16-31 nohz_full=16-31"
        grub2-mkconfig -o /etc/grub2.cfg
        重启机器，  16-31核 100% idle，无网卡磁盘中断， 只有cpu核timer中断
    4）修改CPU模式 高性能
    tuned-adm profile network-latency && tuned-adm active

    