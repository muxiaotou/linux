#only a example
#parse node_list file function
function parse_node_list(){
    sed -i '/^\s*$/d' $1
    datanode_line_number=$(grep -n 'datanode' $1 |cut -d ':' -f1)
    disk_line_number=$(grep -n 'disk' $1 |cut -d ':' -f1)

    datanode_count=0
    total_disk_count=0
    current_line=1

    for line in `cat $1`;do
        if [ $current_line -gt $datanode_line_number ] && [ $current_line -lt $disk_line_number ];then
            datanode_count=$((datanode_count+1))
	fi
        if [ $current_line -gt $disk_line_number ];then
            total_disk_count=$((total_disk_count+1))
	fi
	current_line=$((current_line+1))
    done
    echo "[INFO] datanode host count is ${datanode_count}"
    echo "[INFO] total disk count is ${total_disk_count}"

    datanode_host_list=($(awk "NR > ${datanode_line_number} && NR <= ${datanode_line_number}+${datanode_count}" $1))
    disk_list=($(awk "NR > ${disk_line_number} && NR <= ${disk_line_number}+${total_disk_count}" $1))
    disk_count_per_host=$((${total_disk_count}/${datanode_count}))
    echo "[INFO] datanode host list is ${datanode_host_list[*]}"
    echo "[INFO] disk list is ${disk_list[*]}"
    echo "[INFO] per host disk count is ${disk_count_per_host}"
}

#parse node list
parse_node_list $1

