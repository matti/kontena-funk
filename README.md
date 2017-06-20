# kontena-funk

serverless functions with Kontena scheduling.

## demo

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

With environment variables:
```
$ curl -G --header "X-Funk-ENV_FUNK_A: 123" --data-urlencode "image=alpine:3.5" --data-urlencode "cmd=/bin/sh -c 'export'" funk.yourgrid.com/v1
export FUNK_A='123'
export HOME='/root'
export HOSTNAME='f-24b5ef6e-4fdb-44c7-ae16-5a2855bba8ec-1'
export KONTENA_GRID_NAME='yourgrid'
export KONTENA_NODE_NAME='e-3dsk.c.yourgrid.internal'
export KONTENA_SERVICE_ID='59493cdfdb8d9500080e53c9'
export KONTENA_SERVICE_INSTANCE_NUMBER='1'
export KONTENA_SERVICE_NAME='f-24b5ef6e-4fdb-44c7-ae16-5a2855bba8ec'
export KONTENA_STACK_NAME='null'
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
export PWD='/'
export SHLVL='1'
```


## what?

- Creates a Kontena service named `f-UUID-UUID-UUID-UUID` from the requested container with `sleep TIMEOUT`
- `kontena service exec`s the cmd to the container
- Removes the service, returns the output
- [cleans orphaned services every TIMEOUT+1s]

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
> FUNK_AFFINITY : label==funk=yes
> Enter lb_domain : func.mygrid.com
> Force kontena/lb to redirect SSL if request is not SSL? : depends
> Force kontena/lb to redirect SSL if header X-Forwarded-Proto is not https? : depends
```

## dev

```
[RACK_ENV=development] bin/serve
bin/test
```

# TODO

- `output_` files can be left behind, write a cleaner
