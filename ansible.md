    
    ansbile执行shell命令
    ansible -i host2  all -m shell -a "uname -r"  

---

    ansible Facts变量
    ansible-playbook -i host2 main.yml
    ansible-playbook -i 10.226.136.197, main.yml
    cat main.yml 
    ---
    - hosts: all
      gather_facts: True
      tasks:
        - name: ls cbd.ko      
          shell: "cd /lib/modules/{{ ansible_kernel }}/kernel/drivers/block/ && md5sum cbd.ko"

    inventory_hostname 清单文件hosts当中的配置，可以是域名或者ip
    ansible_hostname  由ansible发现的主机名