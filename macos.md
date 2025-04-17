# MAC OS

Show all DNS servers

```
scutil --dns | grep 'nameserver\[[0-9]*\]'
```

Connect with console

```
ls /dev/tty*
screen /dev/tty.usbserial-xxxx 9600
```