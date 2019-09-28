# 如何在 [kdocker] 中，使用 xdebug

> ***注: 这里只说明预设选项，如果自行调整后坏掉了，请自行负责***

## 环境

> 目前只用在 [IntelliJ-IDEA] ([PhpStorm]) 家族中使用过，其他操作方式应该类似

### [IntelliJ-IDEA] 家族

应该可以应用的环境包括：

- [IntelliJ-IDEA]
- [PhpStorm]
- [WebStorm]
- ...

### [kdocker] 环境

也就是[本专案][kdocker]

## 设定

### [本专案][kdocker]

#### 步骤

1. 设定你自己本身的 `.env` 环境，主要应该是从根目录的 `env-default` 辅助产生的
1. 确定你的 `PHP_FPM_INSTALL_XDEBUG` 设定为 `true`
    > `PHP_FPM_INSTALL_XDEBUG` 设为 `true` 时，才会真的开启 **xdebug** 功能
1. 调整 `WORKSPACE_PHP_XDEBUG_PORT` 或是 `PHP_FPM_PHP_XDEBUG_PORT`
    > 如果你主要是使用web 操作(php-fpm) 时，则参照`PHP_FPM_PHP_XDEBUG_PORT` 的port 号，如果是cli 操作的(workspace)，则参照`WORKSPACE_PHP_XDEBUG_PORT` 这个port 号，当然，这两个port 号*不应该* 相同，或是与其他port 重复
1. 根据需求，调整 *php-fpm* 和/或 *workspace* 资料夹中的 ***xdebug.ini*** 这个档案 (optional)
    > 注意，不要调整 `xdebug.remote_port` 这个参数，一旦改了，相关的 port 号就不对了

> ***再次强调：这里主要说明预设选项，如果自行调整后无法使用，请自行负责***

### [IntelliJ-IDEA]

#### 步骤

1. 设定连线到远端 `Docker` 环境，也就是连到[本专案][kdocker]的 `Docker` 环境
    > 这边先不赘述，可以参考其他网路上的教学说明
1. 设定远端 docker 的 **xdebug** 的 port 号
    > 这个port 号主要是要看我们先前使用的主要开发环境所设的port 号，在此我们使用的是web 操作，所以主要是参考`PHP_FPM_PHP_XDEBUG_PORT` 的设定值，在这里是***9001** *
    >
    > ![设定 xdebug port](../images/xdebug-1.png)
1. 设定相关 xdebug 的 server 环境
    > - 其中的 *IDE Key* 就设定为 `PHPSTORM` (这是预设值)
    > - ×Host* 就是连接到你的 [kdocker] 中 web server 的位址，可以是 ip、hostname 或是 domain name，只要连得到就好
    > - *Port* 号仍然是你刚才设定的 **xdebug port** 。在这里仍然设定 ***9001***
    >
    > ![设定 xdebug 连线方式](../images/xdebug-2.png)
1. 设定 *xdebug* 与开发环境相关对应的位置
    > - *Name* 预设的设定值使用`kimer`，这也是`.env` 环境中`PHP_IDE_CONFIG` 这个设定值中`serverName` 指定的值，在此是`kimer` (一般[Intellij-IDEA]相关设定都可以随意给设定名称，但是这里的设定，一定要与`PHP_IDE_CONFIG=serverName` 指定的值相同，否则***xdebug*** 没办法正常运作***非常重要、非常重要、非常重要***)
    > - *Host* 与刚才前一步设定的方式相同，就是连接到 [kdocker] 中 web server 的位址，可以是 ip、hostname 或是 domain name，只要连得到就好
    > - *Absolute path on the server* 这是指在远端 server (也就是 [kdocker] 中的) 的绝对路径，这里我们使用的是 pt1 相关设定，所以我们设为 `/var/www/pt1`
    >
    > ![设定 server 相关 mapping](../images/xdebug-3.png)

[intellij-idea]: https://www.jetbrains.com/idea/ "Intellij-IDEA"
[PhpStorm]: https://www.jetbrains.com/phpstorm/ "PhpStorm"
[WebStorm]: https://www.jetbrains.com/webstorm/ "WebStorm"
[kdocker]: https://github.com/poyhsiao/kdocker "kdocker"
