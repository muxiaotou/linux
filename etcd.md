# 安装包的获取
    yum install etcd -y
    https://vault.centos.org/7.5.1804/extras/x86_64/Packages/
    https://github.com/etcd-io/etcd/releases/tag/v3.4.16 当中curl tar.gz包
    
# 部署文档及脚本
    1.安装etcd到3个节点，并分别执行以下步骤
    2.创建etcd数据目录
        mkdir -p /data/etcd
    3.修改环境变量
        vim .bashrc 增加export ETCDCTL_API=3，source .bashrc
    4.撰写启动脚本
    # for node1
    vim start_etcd.sh
    #!/bin/bash
    THIS_NAME="etcd_1"
    THIS_IP="10.226.134.187"
    CLUSTER="etcd_1=http://10.226.134.187:2380,etcd_2=http://10.226.134.188:2380,etcd_3=http://10.226.134.189:2380"
    CLUSTER_STATE="new"
    nohup etcd --data-dir=/data/etcd/data.etcd --name ${THIS_NAME} \
           --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
           --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
           --initial-cluster ${CLUSTER} \
           --initial-cluster-state ${CLUSTER_STATE} > /var/log/etcd.log 2>&1 &
        
    # for node2
    vim start_etcd.sh
    #!/bin/bash
    THIS_NAME="etcd_2"
    THIS_IP="10.226.134.188"
    CLUSTER="etcd_1=http://10.226.134.187:2380,etcd_2=http://10.226.134.188:2380,etcd_3=http://10.226.134.189:2380"
    CLUSTER_STATE="new"
    nohup etcd --data-dir=/data/etcd/data.etcd --name ${THIS_NAME} \
           --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
           --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
           --initial-cluster ${CLUSTER} \
           --initial-cluster-state ${CLUSTER_STATE} > /var/log/etcd.log 2>&1 &

    # for node3
    vim start_etcd.sh
    #!/bin/bash
    THIS_NAME="etcd_3"
    THIS_IP="10.226.134.189"
    CLUSTER="etcd_1=http://10.226.134.187:2380,etcd_2=http://10.226.134.188:2380,etcd_3=http://10.226.134.189:2380"
    CLUSTER_STATE="new"
    nohup etcd --data-dir=/data/etcd/data.etcd --name ${THIS_NAME} \
           --initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
           --advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
           --initial-cluster ${CLUSTER} \
           --initial-cluster-state ${CLUSTER_STATE} > /var/log/etcd.log 2>&1 &
           
# 集群状态检查
    [root@cfs-node3 ~]# etcdctl --endpoints=10.226.134.187:2379,10.226.134.188:2379,10.226.134.189:2379 endpoint status --write-out=table
    +---------------------+------------------+---------+---------+-----------+-----------+------------+
    |      ENDPOINT       |        ID        | VERSION | DB SIZE | IS LEADER | RAFT TERM | RAFT INDEX |
    +---------------------+------------------+---------+---------+-----------+-----------+------------+
    | 10.226.134.187:2379 | 9db06f662db9fdaf |  3.3.11 |   20 kB |      true |       543 |          9 |
    | 10.226.134.188:2379 | b9e32a059834f2d9 |  3.3.11 |   20 kB |     false |       543 |          9 |
    | 10.226.134.189:2379 | 21ea28f732549397 |  3.3.11 |   20 kB |     false |       543 |          9 |
    +---------------------+------------------+---------+---------+-----------+-----------+------------+
    
    [root@cfs-node3 ~]# etcdctl --endpoints=10.226.134.187:2379,10.226.134.188:2379,10.226.134.189:2379 member list
    21ea28f732549397, started, etcd_3, http://10.226.134.189:2380, http://10.226.134.189:2379
    9db06f662db9fdaf, started, etcd_1, http://10.226.134.187:2380, http://10.226.134.187:2379
    b9e32a059834f2d9, started, etcd_2, http://10.226.134.188:2380, http://10.226.134.188:2379
     
# 遇到的问题
    [root@cfs-node3 ~]# etcdctl --endpoints=10.226.134.187:2379,10.226.134.188:2379,10.226.134.189:2379 endpoint status --write-out=table
    Failed to get the status of endpoint 10.226.134.187:2379 (context deadline exceeded)
    Failed to get the status of endpoint 10.226.134.188:2379 (context deadline exceeded)
    Failed to get the status of endpoint 10.226.134.189:2379 (context deadline exceeded)
    +----------+----+---------+---------+-----------+-----------+------------+
    | ENDPOINT | ID | VERSION | DB SIZE | IS LEADER | RAFT TERM | RAFT INDEX |
    +----------+----+---------+---------+-----------+-----------+------------+
    +----------+----+---------+---------+-----------+-----------+------------+
    iptalbes -L查看新装的3台节点配置了很多的规则，iptables -F全部进行了清除
    
# etcd一些操作记录
    ETCDCTL_API=3 etcdctl get "" --from-key #获取所有的键值
    ETCDCTL_API=3 etcdctl get "" --from-key --keys-only #只获取所有的key不含value
    ETCDCTL_API=3 etcdctl get "" --from-key --keys-only --limit 3 #获取key只显示3个
    ETCDCTL_API=3 etcdctl get --prefix my #获取所有以my开头的key及对应value
    ETCDCTL_API=3 etcdctl del my --prefix #删除所有以my开头的键值
    