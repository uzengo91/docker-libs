# 构建参考

[host.docker.internal](https://www.cnblogs.com/wt20/p/17515038.html)
[ip addr](https://alparslanozturk.medium.com/redis-cluster-in-5-minute-798b98601e3b)

# 变量参考

1. cluster-announce-ip
作用：指定当前节点向 Redis 集群通告的 IP 地址。
默认值：如果未配置，Redis 会自动检测节点的本地 IP。
配置方式：适用于跨主机部署的场景，如在 NAT 或 Docker 环境中运行 Redis 节点时。
示例：

```conf
cluster-announce-ip 192.168.1.100
```

2. cluster-announce-port

作用：指定当前节点向 Redis 集群通告的服务端口（也就是客户端访问 Redis 的端口）。
默认值：如果未配置，使用 port 配置的值（默认 6379）。
配置方式：适用于当节点的服务端口与实际通告端口不同的场景。
示例：

```conf
cluster-announce-port 6379
```

3. cluster-announce-bus-port

作用：指定当前节点向 Redis 集群通告的总线端口。
总线端口用于集群节点之间的通信，如槽（slot）迁移、故障检测等。
默认值为 port + 10000。
默认值：如果未配置，Redis 会自动将主端口号加 10000。
配置方式：适用于需要显式指定总线端口的场景，如防火墙规则限制的情况下。
示例：

```conf
cluster-announce-bus-port 16379
```

使用场景
Docker 或 NAT 环境
在 Docker、Kubernetes 或 NAT 网络中运行 Redis 集群时，节点的实际 IP 和端口可能与其自我检测的 IP 和端口不同。此时必须配置 cluster-announce-ip 和相关端口，否则集群节点之间以及客户端无法正确通信。

高可用场景
在跨数据中心或多网段的 Redis 集群部署中，cluster-announce-* 配置可以显式指定集群通信信息，确保节点间连通性。
