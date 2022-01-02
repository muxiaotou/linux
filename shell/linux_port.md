    https://developer.51cto.com/art/201906/597961.htm
    https://www.cnblogs.com/solohac/p/4154180.html

    linux端口范围0~65535之间：
    0~1023：比如http、ftp、telnet等广为使用的应用协议的固定端口
    1024~49151：
    49152~65535：操作系统可以动态分配给应用程序的端口范围(比如一些程序的client端无需自己指定port，而交由操作系统去随机选择一个端口)

    cat /proc/sys/net/ipv4/ip_local_port_range 查看本地tcp/udp的端口范围，即系统中程序会选择这个范围内的端口来链接到目的端口,
    目的端口是用户启动程序时用户指定的(理解程序的server端port)。
    如果需要修改此端口范围，可以vim /etc/sysctl.conf ，
    net.ipv4.ip_local_port_range = 1024  65535
    然后sysctl -p /etc/sysctl.conf重新加载使生效