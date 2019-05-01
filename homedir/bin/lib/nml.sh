#!/bin/echo Error: sourcing -*- sh -*-

# (SUDO) nmap and lists IP => MAC addr (vendor name) for an NMAP range
function nml() {
   sudo nmap -sn "$@" | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " => "substr($0, index($0,$3)) }' | sort --version-sort
 }
