
Nginx load-balancer backed by etcd
=======================================

etcd tree
```
/nginx/hosts/
			:project/
				hostname = www.project.com
				# fontend balancers
				web/
					:id = ip
				# backend balancers
				app/
					:id = ip

```
Example
=======
```
/nginx/hosts/
			cydev/
				hostname = cydev.ru
				web/
					1 = 10.0.0.1
					2 = 10.0.0.2
```
Will generate
```
upstream cydev {
	server 10.0.0.1;
	server 10.0.0.2;
}

server {
    server_name cydev.ru
    location / {
        proxy_pass         http://cydev;
        include includes/proxy.cfg;
   }
}
```

