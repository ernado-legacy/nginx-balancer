
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
        proxy_pass http://cydev;
        include    includes/proxy.cfg;
   }
}
```
Where proxy.cfg is 
```
proxy_redirect     off;
proxy_http_version 1.1;
proxy_set_header   Host             $host;
proxy_set_header   X-Real-IP        $remote_addr;
proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
proxy_set_header   Upgrade          $http_upgrade;
proxy_set_header   Connection       $connection_upgrade;
```
