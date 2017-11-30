# TorCheck
Check if any IPs in a capture file are using ToR. e.g output:

```
./torCheck.sh tor_data.pcap
[+] Checking if any devices in tor_data.pcap are using ToR
[+] Downloading ToR entry node list...
[+] Extracting IPs from tor_data.pcap and writing to ips-29782.txt...
[-] ToR entry nodes:  6291
[+] IPs in capture file:  84
[-] Checking IP list against known ToR entry nodes:
[+] Entry node ToR IPs in tor_data.pcap:

192.42.115.101
81.7.10.251

```
