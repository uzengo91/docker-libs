rm -rf ./data
i=1
for port in $(seq 6381 6386);
do
    ipAddr=172.18.144.10${i}
    ip addr replace ${ipAddr}/32 dev eth0
    conf_dir=./data/redis_${port}/conf
    conf_file=${conf_dir}/redis.conf
    if [ ! -d ${conf_dir} ]; then
        mkdir -p ${conf_dir}
    fi
    if [ -f ${conf_file} ]; then
        rm -f ${conf_file}
    fi
    i=$((i+1))
    touch ${conf_file}
    cat  << EOF > ${conf_file}
bind 0.0.0.0
port ${port}
# requirepass 123456
# masterauth 123456
dir /data
appendonly yes
cluster-enabled yes 
cluster-config-file nodes-${port}.conf
cluster-node-timeout 5000
cluster-announce-ip host.docker.internal
# cluster-announce-ip ${ipAddr}
cluster-announce-port ${port}
cluster-announce-bus-port 1${port}
EOF
done

