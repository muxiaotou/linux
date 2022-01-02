    NF：当前行的列数，可以用来打印最后一列    
    awk -F':' '{print $NF}' /etc/passwd

    NR：当前行的行号
    awk "NR>1&&NR<6" /etc/passwd