# What's it?
This is a virtual machine with NGINX and PHP-FPM 7. It is based on Alpine Linux and works via Vagrant.

# What's inside?
* NGINX
* PHP-FPM 7
* Composer

# How to install?
* Clone this repo and execute ```vagrant up```;
* Add into your hosts file next rows:
```
192.168.0.135 webdevbox.local
192.168.0.135 first_site.local
192.168.0.135 second_site.local
```
* When vagrant will complete installation - check it in your browser:
```
http://webdebbox.local
http://first_site.local
http://second_site.local
```
* Enjoy!

# How to add new sites?
* Create a new configuration file in ```sites-conf``` folder, like ```003-my_awesome_site.conf```;
* Open it in any text editor and configurate it (see Nginx docs);
* Execute ```vagrant ssh``` in your host machine's console;
* Execute ```sudo nginx -s reload``` in VM's console;
* Check a new site in your browser. 
