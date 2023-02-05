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
Depend of the context but sometimes we need to play with redirect or with __RPZ__.
 * __Redirect__ is used when you want to block all subdomains under a TLD, including those which do not yet exist. 
 * __RPZ__ in more fine tuning you can apply policy for eachs records, compare to __redirect__, if a record is not under __RPZ__ policy, resolution is provided❗️

## Redirect
 * [2pz-l1s7-ph15h1n9-003.txt](https://github.com/seheyah/unbound/blob/main/2pz-l1s7-ph15h1n9-003.txt)<br>
This list is a redirect received all TLD coming from 🇫🇷 SMS services not listed in the list in the list __2pz-l1s7-ph15h1n9-001.txt__

## RPZ
 *
 
## Script
 * [unbound-ph15h1n9-001.sh](https://github.com/seheyah/unbound/blob/main/unbound-ph15h1n9-001.sh)<br>
 This script download and format __redirect__ file coming from [Red Flag Domains](https://red.flag.domains)
 💡Crontab @daily is quite enough
 
## Blueteam - Check new settings
You can test your Unbound server configuration here:
 * [1.1.1.1](https://1.1.1.1/help)

🐡 Have fun!
