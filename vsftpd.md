# 问题
    要上传大于4GB文件到linux服务器，rz命令不支持4GB往上文件传输，在linux服务器上装了一个vsftpd服务，windows端通过FileZilla匿名上传
    参考文档： https://blog.51cto.com/hexiaoshuai/2461146
    
# 步骤记录
    1. yum install vsftpd -y
    2. 编辑vsftpd服务配置文件vim /etc/vsftpd/vsftpd.conf
        anonymous_enable=YES    #默认为YES
        no_anon_password=YES    # 在配置文件最后面加上下面的配置，然后重启vsftpd
        anon_upload_enable=YES  #把前面的#去掉即可，即支持任何用户上传
        # 默认情况下，数据存储/var/ftp/pub目录权限为755，所以匿名用户无法往这个目录上传文件，chmod 777 /var/ftp/pub
        
    
    