    查看core的方法
    1）使用file命令查看堆栈的方法
    file core-0.5-dev--1507989-1647960692
    from 字段后面那个就是生成这个core的二进制路径，有时候由于路径过长显示不全，需要自己补全一下

    2）打开core
    gdb bin文件 core文件

    3）打开之后使用bt命令查看
    常见问题是看到一堆问号，??? 不显示栈信息，这种一般是core没有生成完全，在生成core的时候被kill掉了，在用gdb打开的时候会有提示