# Difference between _JAVA_OPTIONS, JAVA_TOOL_OPTIONS and JAVA_OPTS

JAVA_OPTS: 无法正常读取
JAVA_TOOL_OPTIONS：可以正常读取，但是容器中每个java 相关指令都会带上这些参数，如果有端口绑定信息，可能会无法正常运行其他指令
_JAVA_OPTIONS：不推荐，只存在于某些特殊发行版的jvm中

[ref](https://stackoverflow.com/questions/28327620/difference-between-java-options-java-tool-options-and-java-opts)

## 推荐方案

``` bash
新增一个脚本，
#!/bin/bash
java -jar $JAVA_OPTS app.jar

```
