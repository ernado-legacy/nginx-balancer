
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
