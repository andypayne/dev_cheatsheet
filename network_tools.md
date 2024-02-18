# Network Tools

## iperf

```
$ iperf -t 90 -i 1 -c 10.1.2.46
------------------------------------------------------------
Client connecting to 10.1.2.46, TCP port 5001
TCP window size: 45.0 KByte (default)
------------------------------------------------------------
[  1] local 10.1.2.159 port 44090 connected with 10.1.2.46 port 5001
[ ID] Interval           Transfer     Bandwidth
[  1] 0.0000-1.0000 sec  6.38 MBytes  53.5 Mbits/sec
[  1] 1.0000-2.0000 sec  6.25 MBytes  52.4 Mbits/sec
[  1] 2.0000-3.0000 sec  7.00 MBytes  58.7 Mbits/sec
[  1] 3.0000-4.0000 sec  5.38 MBytes  45.1 Mbits/sec
...
[  1] 90.0000-90.5475 sec   128 KBytes  1.92 Mbits/sec
[  1] 0.0000-90.5475 sec   436 MBytes  40.4 Mbits/sec
```


## netperf

```
$ netperf -H 10.1.2.46 -l 100 -t TCP_RR -v 2 -- -o min_latency,mean_latency,max_latency,stddev_latency,transaction_rate
MIGRATED TCP REQUEST/RESPONSE TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.1.2.46 () port 0 AF_INET : demo : first burst 0
Minimum Latency Microseconds,Mean Latency Microseconds,Maximum Latency Microseconds,Stddev Latency Microseconds,Transaction Rate Tran/s
64081,75600.31,166938,13199.22,13.218
```


## MTR

```
$ mtr --no-dns --report --report-cycles 60 10.1.2.46
Start: 2023-08-15T13:53:26-0700
HOST: L-32433J3                   Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 10.1.2.1                   0.0%    60    0.6   0.5   0.2   3.1   0.4
  2.|-- 10.1.2.1                   0.0%    60  110.0  76.9  61.3 140.1  16.8
  3.|-- ???                      100.0     60    0.0   0.0   0.0   0.0   0.0
  4.|-- ???                      100.0     60    0.0   0.0   0.0   0.0   0.0
  5.|-- 169.254.32.2              0.0%     60   65.1  77.6  65.1 144.4  18.0
  6.|-- 10.1.6.1                  0.0%     60   68.7  75.4  65.1 109.1  12.2
  7.|-- 10.1.2.46                 0.0%     60   67.4  78.0  64.9 148.3  16.4
```


## hping3

To ping a host that doesn't respond to pings, but is listening on SSH (22):

```
sudo hping3 -A -n -p 22 1.2.3.4
HPING 1.2.3.4 (eth0 1.2.3.4): A set, 40 headers + 0 data bytes
len=40 ip=1.2.3.4 ttl=22 id=15339 sport=22 flags=RA seq=0 win=512 rtt=80.0 ms
len=40 ip=1.2.3.4 ttl=25 id=21772 sport=22 flags=RA seq=1 win=512 rtt=79.5 ms
len=40 ip=1.2.3.4 ttl=22 id=24289 sport=22 flags=RA seq=2 win=512 rtt=79.4 ms
len=40 ip=1.2.3.4 ttl=25 id=56286 sport=22 flags=RA seq=3 win=512 rtt=79.3 ms
len=40 ip=1.2.3.4 ttl=25 id=37137 sport=22 flags=RA seq=4 win=512 rtt=78.9 ms
len=40 ip=1.2.3.4 ttl=25 id=9908 sport=22 flags=RA seq=5 win=512 rtt=88.8 ms
len=40 ip=1.2.3.4 ttl=25 id=41680 sport=22 flags=RA seq=6 win=512 rtt=68.6 ms
len=40 ip=1.2.3.4 ttl=25 id=31522 sport=22 flags=RA seq=7 win=512 rtt=68.2 ms
len=40 ip=1.2.3.4 ttl=22 id=57012 sport=22 flags=RA seq=8 win=512 rtt=68.2 ms
^C
--- 1.2.3.4 hping statistic ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 68.2/76.8/88.8 ms
```
