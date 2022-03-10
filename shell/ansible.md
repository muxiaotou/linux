# shell命令执行
    一条命令可以直接使用shell模块：
    - name: Exec a shell command
      shell: echo "my name is mutouchen"

    多条命令（&&）
    - name: Exec some shell command
      shell: echo "my name is mutouchen" && hostname

    多条命令(|)
    - name: Exec some shell command
      shell: |
        echo "my name is mutouchen"
        hostname

    多条命令(;)
    - name: Exec some shell command
      shell: 
        echo "my name is mutouchen";
        hostname