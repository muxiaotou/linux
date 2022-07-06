    
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