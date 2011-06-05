# httpd module
# created by <arnobroekhof@gmail.com>
# Version 0.1
#
# Usage:
#
# include httpd
# httpd::ssl_website {	'websitename': ssl_bind_address => 'xxx.xxx.xxx.xxx',
#                                ssl_certificate => '/path/to/crt/file.crt',
#                                ssl_keyfile => '/path/to/key/file.key',
#                                server_name => 'www.somewebsite.com/'  }
# if you leave ssl_certificate empty then an self signed certificate will be created
#
#httpd::ssl_website_proxy{ 'websitename':       ssl_bind_address => 'xxx.xxx.xxx.xxx',
#                                		ssl_certificate =>'/path/to/crt/file.crt',
#                                		ssl_keyfile => '/path/to/key/file.key',
#                                		server_name => 'www.somewebsite.com',
#                                		proxy_website => 'http://somehost:someport/',
#                                		proxy_path => '/' }
# if you leave ssl_certificate empty then an self signed certificate will be created
#
# httpd::website{ 'websitename':
#				bind_address => 'xxx.xxx.xxx.xxx',
#				server_name => 'www.somewebsitename.com' }
#
# httpd::website_proxy { 'websitename':
#				bind_address => 'xxx.xxx.xxx.xxx',
#				server_name => 'www.somewebsitename.comf',
#				proxy_path => '/',
#				proxy_website => 'http://somehost:someport/'


import "classes/*.pp"
import "defines/*.pp"
