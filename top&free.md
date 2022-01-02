    显示某个进程的所有线程
    top -H -p 38319

    显示某个进程或者线程cpu的亲和性
    taskset -pc 38436

    free:
    # free -m
              total        used        free      shared  buff/cache   available
    Mem:         128269        8895         963          46      118409      118290
    Swap:         16383          76       16307
    Mem行是内存的使用情况；Swap是交换空间的使用情况
    total列显示系统总的可用物理内存和交换空间的大小
    used列显示被使用的物理内存和交换空间
    free列显示还有多少物理内存和交换空间可以使用
    shared列显示被共享使用的物理内存大小
    buff/cache列显示被buffer和cache使用的物理内存大小
    available列显示还可以被应用程序使用的物理内存大小

    buffer/cache
    buffer是对磁盘数据的缓存，cache是对文件数据的缓存，当应用程序需要内存时，如果没有足够的free内存可用，内核
    就会从buffer和cache中回收内存来满足应用程序的请求，因此从应用角度availabel= free + buffer + cache.

    free & available
    free是真正尚未被使用的物理内存，available比较有意思，是从应用角度看到的可用内存数量，available = free + 
    buffer + cache

    