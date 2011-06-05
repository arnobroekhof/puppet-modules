# httpd module
# created by <arnobroekhof@gmail.com>
# Version 0.1
#
# Usage:
#
# include httpd
# httpd::ssl_website (	ssl_bind_address => 'xxx.xxx.xxx.xxx',
#                                ssl_certificate => '/path/to/crt/file.crt',
#                                ssl_keyfile => '/path/to/key/file.key',
#                                server_name => 'www.somewebsite.com' 
# if you leave ssl_certificate empty then an self signed certificate will be created
#
#httpd::ssl_website_proxy(       ssl_bind_address => 'xxx.xxx.xxx.xxx',
#                                ssl_certificate =>'/path/to/crt/file.crt',
#                                ssl_keyfile => '/path/to/key/file.key',
#                                server_name => 'www.somewebsite.com',
#                                proxy_website => 'http://somehost:someport',
#                                proxy_path => '/' ) {
# if you leave ssl_certificate empty then an self signed certificate will be created
#
# TODO
# create website and website_proxy define


import "classes/*.pp"
import "defines/*.pp"
