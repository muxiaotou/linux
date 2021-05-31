# 需求
    centos节点上有闲置的磁盘通过iscsi导出，vsphere节点上通过iscsi使用这些磁盘
    https://www.jianshu.com/p/b48e3fec1303
    https://blog.csdn.net/allway2/article/details/102880332
    
# 配置步骤
    iscsi基于server-client模型，提供存储资源的target端相当于server，使用远程资源的initiator端相当于client
    target端常见的工具有targetcli(Llinx-IO)、targetadm、ietadm
    initiator端工具可以用iscsiadm
    
    yum install epel-release
    yum install targetcli
    systemctl start target
    systemctl enable target
    
    # targetcli
    // 创建后台存储
    /> cd backstores/block
    /backstores/block> create name=datastore dev=/dev/sdb
    // 创建iscsi目标
    /> cd iscsi
    /iscsi> create iqn.2021-05.local.disk.server:datastore
    // 创建ACL
    /> cd iscsi/iqn.2021-05.local.disk.server:datastore/tpg1/acls
    /iscsi/iqn.20...ore/tpg1/acls> create iqn.2021-05.local.disk.server:datastore
    // 创建要导出的逻辑LUN
    /iscsi> cd iqn.2021-05.local.disk.server:datastore/tpg1/luns
    /iscsi/iqn.20...ore/tpg1/luns> create /backstores/block/datastore
    
    /> saveconfig
    /> exit
    
    
    
    
    
    
    