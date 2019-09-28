# How to use xdebug in [kdocker]

> ***Note: Only the default options are explained here. If it is broken after self-adjustment, please be careful***

## surroundings

> Currently only used in the [IntelliJ-IDEA] ([PhpStorm]) family, the other IDEs should be very similar

### [IntelliJ-IDEA] Family

The environments that should be the same, including:

- [IntelliJ-IDEA]
- [PhpStorm]
- [WebStorm]
- ...

### [kdocker] Environment

That is [this project][kdocker]

## Setting up

### [This project - kdocker][kdocker]

#### Steps

1. Set your own `.env` file, which should be generated from `env-default` in the root directory of this project.
1. Make sure your `PHP_FPM_INSTALL_XDEBUG` should be set `true`
    > `PHP_FPM_INSTALL_XDEBUG` **MUST** be `true` to enabel *xdebug* feature.
1. Update `WORKSPACE_PHP_XDEBUG_PORT` and/or `PHP_FPM_PHP_XDEBUG_PORT` parameters
    > If your project is a web application (php-fpm), please update the port number of `PHP_FPM_PHP_XDEBUG_PORT`. If the project runs under command line, you should update `WORKSPACE_PHP_XDEBUG_PORT` port number. Of course, these both port numbers should not be the same nor duplicated with the other service port number.
1. Adjust the ***xdebug.ini*** file in the *php-fpm* and/or *workspace* folders as needed (optional)
    > Note, DO NOT update the `xdebug.remote_port` parameter. Once changed, the related port number is wrong.

> ***AWARE: This is document is an example with the default settings. Maybe you can't execute [this project][kdocker] correctly if you modified some settings***

### [IntelliJ-IDEA]

#### Steps

1. Set up the the remote [Docker][kdocker] environment in the IDE that should connect to [this project][kdocker].
    > This document will not help you how to set the connection to the remote [docker][kdocker]. It will be just focus on setting up xdebug environment.
1. Set the port number of the remote docker's **xdebug**
    > For this example, our project is a web service, we use `PHP_FPM_PHP_XDEBUG_PORT` as our *xdebug* port where is ***9001***.
    >
    > ![Set xdebug port](../images/xdebug-1.png)
1. Set the network setting to connect to xdebug
    > - *IDE Key* is set to `PHPSTORM` (this is the default).
    > - ×Host* is the address of the web server connected to your [kdocker], which can be ip address, hostname ,or domain name whatever you can connect to your *xdebug* server.
    > - *Port* is still the **xdebug port** you just set. Still set ***9001*** here.
    >
    > ![Set xdebug connection method](../images/xdebug-2.png)
1. Set *xdebug* to correspond to the development environment
    > - *Name* The default setting value uses `kimer`, which is also the value specified by `serverName` in the setting value of `PHP_IDE_CONFIG` in the `.env` environment, here is `kimer` (general [Intellij-IDEA] The relevant settings can be given a name, but the settings here must be the same as the value specified by `PHP_IDE_CONFIG=serverName`, or ***xdebug*** can't work normally. *** Very important, very important, very important ***)
    > - *Host* is the same as the one set in the previous step, which is the address of the web server connected to [kdocker], which can be ip address, hostname or domain name.
    > - *Absolute path on the server* This refers to the absolute path in the remote server (that is, in [kdocker]), here we use the pt1 related settings, so we set it to `/var/www/pt1`
    >
    > ![Set server related mapping](../images/xdebug-3.png)

[intellij-idea]: https://www.jetbrains.com/idea/ "Intellij-IDEA"
[PhpStorm]: https://www.jetbrains.com/phpstorm/ "PhpStorm"
[WebStorm]: https://www.jetbrains.com/webstorm/ "WebStorm"
[kdocker]: https://github.com/poyhsiao/kdocker "kdocker"
