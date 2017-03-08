#!/bin/sh
# Filename: route_up.sh
# Description: script that is executed by openVPN 'route-up' option and adds a possibility to use vpn as a separate channel (PHP Guzzel for example)
#
# Brief vpn parameters descriptions:
#
# dev - The actual name of the TUN/TAP device, including a unit number if it exists. Set prior to --up or --down script execution;
# ifconfig_local - The local VPN endpoint IP address specified in the --ifconfig option (first parameter).
#                  Set prior to OpenVPN calling the ifconfig or netsh (windows version of ifconfig) commands which normally occurs prior to --up script execution.
#
# ifconfig_remote - The remote VPN endpoint IP address specified in the --ifconfig option (second parameter) when --dev tun is used.
#                   Set prior to OpenVPN calling the ifconfig or netsh (windows version of ifconfig) commands which normally occurs prior to --up script execution.
#
# route_vpn_gateway - The default gateway used by --route options, as specified in either the --route-gateway option
#                     or the second parameter to --ifconfig when --dev tun is specified. Set prior to --up script execution.

echo "$dev : $ifconfig_local -> $ifconfig_remote gw: $route_vpn_gateway"

ip route add default via $route_vpn_gateway dev $dev table 20
ip rule add from $ifconfig_local table 20
ip rule add to $route_vpn_gateway table 20
ip route flush cache

exit 0
