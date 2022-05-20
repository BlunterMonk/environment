        'LoginSecurity\Logger' => array(
            'writers' => array(
                'login-security' => array(
                    'name' => 'stream',
                    'options' => array(
Code and Vagrant -->

## 0. Assumptions

- You've installed [Xdebug](https://xdebug.org/docs/install) in your VM.
- You've installed [Xdebug extension for VSCode](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug) and reloaded/restarted VSCode.
- You have **not** forwarded port 9000 from the guest to the host.
- Configure Debugger in VSCode. See item 1 next.

## 1. Configure .vscode/launch.json

``` json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "pathMappings": {
                "/vagrant/www": "${workspaceFolder}/www/"
            },
            "port": 9000,
            "log": true,
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9000
        }
    ]
}
```

Note: `${workspaceRoot}` is deprecated, use `${workspaceFolder}`. Also note that the first part of the mapping cannot contain symlinks. Change from `/var/www/html/www` to `/vagrant/www/`

## 2. Check xdebug.ini

Located at `/etc/php/7.0/mods-available/xdebug.ini`

Should contain:

``` ini
zend_extension=xdebug.so
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.max_nesting_level = 512
xdebug.remote_autostart = true
xdebug.remote_host = 10.0.2.2
xdebug.remote_log = /var/log/xdebug.log
```

If you're not sure about the `remote.host`, execute `route -nee` on the VM and look for the gateway:
``` bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface    MSS   Window irtt
0.0.0.0         10.0.2.2        0.0.0.0         UG    0      0        0 enp0s3   0     0      0
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 enp0s3   0     0      0
192.168.33.0    0.0.0.0         255.255.255.0   U     0      0        0 enp0s8   0     0      0
```

Or

``` bash
route -nee | awk '{ print $2 }' | sed -n 3p
10.0.2.2
```

Note: I believe `xdebug.remote_host` is added automatically, but double check:

``` bash
$ php -i | grep xdebug.remote_host
xdebug.remote_host => 10.0.2.2 => 10.0.2.2
```

Also check that the `xdebug.so` is loaded:

``` bash
$ php -m | grep -i xdebug
xdebug
Xdebug
```

## 3. Install an Xdebug helper for your browser

These helpers allow to enable or disable Xdebug instead of setting cookies or URL parameters by yourself.

Here's one for [Chrome](https://chrome.google.com/webstore/detail/xdebug-helper) and one for [Firefox](https://addons.mozilla.org/en-US/firefox/addon/xdebug-helper-for-firefox/).

## 4. Debugging

1. Switch to the Debugger panel and press "Start debugging" button (looks like a green _play_ button at the top). You can also run __Debug: Start debugging__ in the commands palette.
2. __Set a breakpoint__ in the file/line where you want to pause the execution __clicking to the left of the line number in the editor.__ You'll see a _gray_ (unverified) or _red_ (verified) dot.
3. __Make sure the helper is active__ (usually in green) or add the URL parameter, and __load the page/script in which you set the breakpoint__. At this point the page should remain _"loading"_ and the VSCode window become active.
4. Happy debugging!

# Working Config #

xdebug.ini
```
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_autostart=1
xdebug.remote_host=10.0.2.2
xdebug.remote_port=9000
```

launch.json
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "pathMappings": {
                "/var/www/blim/current/": "${workspaceRoot}/"
            },
            "log": true
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9000
        }
    ]
}
```
