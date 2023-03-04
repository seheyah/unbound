# Unbound file configuration and some others tweaks
🎯 This repository hosts a version of Unbound server for [OpenBSD](https://www.openbsd.org) with some tweaks cleaning your web experience.

📝 Here the [man](https://man.openbsd.org/unbound.conf) for unbound configuration file.<br>
📝 Here the [documentation](https://www.nlnetlabs.nl/documentation/unbound/howto-optimise/) to optimize your Unbound with your ressources.<br>
📝 Here the Response Policy Zones (__RPZ__) [documentation](https://unbound.docs.nlnetlabs.nl/en/latest/topics/filtering/rpz.html).<br>

🛡️ Secure your external DNS request with DNS over TLS, configure RPZ option and build lists for a better and more efficient (reducing your carbon impact) web experience.
 
## Prerequisites
 * You need to have an account with doas set correctly.
 * Unbound enable and start:
   * `rcctl enable unbound` 
   * `rcctl start unbound` 
   
 * Activate modules here below in your configuration file `unbound.conf`:
   * module-config: "respip validator iterator"
 * Check your configuration file before reload:
   * `unbound-checkconf /var/unbound/etc/unbound.conf`
   * `rcctl reload unbound`
 
## Usage
For [unbound.conf](https://github.com/seheyah/unbound/blob/main/unbound.conf) change these values:<br>
   * access-control: `your_network_here/CIDR_prefix` allow
   * interface: `your_ip_here`
   * private-address: `your_network_here/CIDR_prefix`

For [unbound-ph15h1n9-001.sh](https://github.com/seheyah/unbound/blob/main/unbound-ph15h1n9-001.sh) update the backup path:<br>
  * filebkp01="your_backup_path/2pz-l1s7-ph15h1n9-001.bkp"

Depend of the context but sometimes we need to play with redirect or with __RPZ__.
 * __Redirect__ is used when you want to block all subdomains under a TLD, including those which do not yet exist. 
 * __RPZ__ in more fine tuning you can apply policy for eachs records, compare to __redirect__, if a record is not under __RPZ__ policy, resolution is provided❗️

## Redirect (2d2)
 * [2d2-l1s7-8l4ckh4t-001](https://github.com/seheyah/unbound/blob/main/2d2-l1s7-8l4ckh4t-001.txt)<br>
 This list is a redirect receiving all TLD known as bad.
 * [2d2-l1s7-ph15h1n9-003.txt](https://github.com/seheyah/unbound/blob/main/2d2-l1s7-ph15h1n9-003.txt)<br>
 This list is a redirect receiving all TLD coming from 🇫🇷 SMS services not listed in the list __2d2-l1s7-ph15h1n9-001.txt__.

## RPZ (2pz)
 * [2pz-l1s7-71k70k-001.txt](https://github.com/seheyah/unbound/blob/main/2pz-l1s7-71k70k-001.txt)<br>
 This list is a RPZ with NXDomain action to the famous . so all T1kT0k will be disabled.
 * [2pz-l1s7-8l4ckh4t-001.txt](https://github.com/seheyah/unbound/blob/main/2pz-l1s7-8l4ckh4t-001.txt)<br>
 This list is a RPZ with sources not in the RPZ malware.
 * [2pz-l1s7-d0h-001.txt](https://github.com/seheyah/unbound/blob/main/2pz-l1s7-d0h-001.txt)<br>
 This list is a RPZ with "famous" DoH.
 
## Script
 * [unbound-ph15h1n9-001.sh](https://github.com/seheyah/unbound/blob/main/unbound-ph15h1n9-001.sh)<br>
 This script download and format __redirect__ file coming from [Red Flag Domains](https://red.flag.domains).<br>
 💡Crontab __@daily__ is quite enough.
 
## Blueteam - Check new settings
You can test your Unbound server configuration here:
 * [1.1.1.1](https://1.1.1.1/help)

🐡 Have fun!
