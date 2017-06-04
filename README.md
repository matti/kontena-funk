# kontena-funk

serverless functions with Kontena scheduling.

## demo:

```
$ curl -G --data-urlencode "image=alpine:3.5" --data-urlencode "cmd=df -h" funk.yourgrid.com/v1
Filesystem                Size      Used Available Use% Mounted on
overlay                  13.2G      1.9G     10.7G  15% /
tmpfs                     1.8G         0      1.8G   0% /dev
tmpfs                     1.8G         0      1.8G   0% /sys/fs/cgroup
/dev/sda9                13.2G      1.9G     10.7G  15% /w-nomcast
/dev/sda9                13.2G      1.9G     10.7G  15% /w-noop
/dev/sda9                13.2G      1.9G     10.7G  15% /w
/dev/sda9                13.2G      1.9G     10.7G  15% /etc/resolv.conf
/dev/sda9                13.2G      1.9G     10.7G  15% /etc/hostname
/dev/sda9                13.2G      1.9G     10.7G  15% /etc/hosts
shm                      64.0M         0     64.0M   0% /dev/shm
tmpfs                     1.8G         0      1.8G   0% /proc/kcore
tmpfs                     1.8G         0      1.8G   0% /proc/latency_stats
tmpfs                     1.8G         0      1.8G   0% /proc/timer_list
tmpfs                     1.8G         0      1.8G   0% /proc/timer_stats
tmpfs                     1.8G         0      1.8G   0% /proc/sched_debug
```

## setup

```
$ kontena master token create -e 0 --token
abbacdabbacd

$ kontena stack install
Pick a loadbalancer lb-ingress/lb
> KONTENA_URL : https://yourmaster.kontena.com
> KONTENA_TOKEN : abbacdabbacd
> KONTENA_GRID : yourgrid
> FUNK_TIMEOUT : 60
> Enter lb_domain : func.mygrid.com
> Force kontena/lb to redirect SSL if request is not SSL? : depends
> Force kontena/lb to redirect SSL if header X-Forwarded-Proto is not https? : depends
```
