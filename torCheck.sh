#!/bin/bash
# @glennzw
# Tiny utility to check if any ToR entry node IP addresses are in a capture file.
#  i.e. are any devices in the capture file using ToR.
#  The Tor list is a snapshot in time so may not work for old pcaps.

if [ $# -eq 0 ]
  then
    echo "[!] Error: Please supply capture file as input."
    exit
fi

INFILE=$1

echo "[+] Checking if any devices in $INFILE are using ToR"

if [ ! -f torlist.txt ]; then
  echo "[+] Downloading ToR entry node list..."
  wget -O torlist.txt https://www.dan.me.uk/torlist/ &>/dev/null
  #wget -O torlist.txt https://pastebin.com/raw/wVzeGh3A &>/dev/null
  if [ ! $? -eq 0 ]; then
    echo "[!] Error: Unable to download ToR list (https://www.dan.me.uk/torlist/). You might be throttled, try again in 30 mins."
    rm torlist.txt #Remove blank file
    exit
  fi
  sort torlist.txt -o torlist.txt
fi
OUTFILE=ips-$RANDOM.txt
echo "[+] Extracting IPs from $INFILE and writing to $OUTFILE..."
tshark -r $INFILE -Y "tcp"  -T fields -e ip.src | sort | uniq > $OUTFILE
echo "[-] ToR entry nodes: " `wc -l <torlist.txt`
echo "[+] IPs in capture file: " `wc -l <$OUTFILE`
echo "[-] Checking IP list against known ToR entry nodes:"
echo "[+] Entry node ToR IPs in $INFILE:"
echo ""
cat torlist.txt $OUTFILE | sort | uniq -d # Hack to find intersection of sort files
