# Bandwidth measurement using iperf3 and RRD

## Build status

[![build status](https://secure.eisendle.net/jenkins/project/bandwidth/status.png?ref=master)](https://secure.eisendle.net/jenkins/job/bandwidth/lastBuild/)

## Setup
### Installation of required components on Debian 8
```
sudo apt-get install iperf3
sudo apt-get install apache2 libapache2-mod-php5
sudo apt-get install rrdtool php5-rrd
```
iperf3 binaries are also available here: <https://iperf.fr/iperf-download.php>
### Iperf server
A remote machine is required which runs an iperf3 server instance.
```
iperf3 -s -D
```
Alternatively, a public iperf3 server can be used. See <https://iperf.fr/iperf-servers.php>. 
## Get the source
```
https://github.com/christianeisendle/bandwidth-measure-rrd.git
````

## Configuration
The iperf3 server must be specified using `BW_IPERF_SERVER` variable either by setting it as environment variable or by specifying it in bandwidth.cfg:
```
BW_IPERF_SERVER=my.iperfserver.com
```
**Note:** bandwidth.cfg *must* exist; it can be empty, though.

## Configure crontab
Example:
```
*/10 * * * * capture_and_update_db_iperf3.sh
```