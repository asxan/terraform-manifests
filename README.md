## Third task №3

#### The third task include work with Load Balancers, Auth scaling, Auth Healing, IAP, HTTPS, SSL/TLS and so on.

Load Balancers:
1. Read the documentation about Load Balancers and watch an official videos from GCP YouTube channel.
2. Create a new Centos packer image with a unique information, for example IP address of the instance. (Provision your instance with a bash scripts (create Nginx installation as for Debian as for Red-Hat systems in one script)) 
3. Create a couple of GCE manage instance group from Nginx(packer) image was created on the previous step. Instance should be located in the two private subnet in different locations(Europe and America). Instances must have access to public internet, but nobody should have access from the public internet. 
4. Create firewall rule to allow traffic from Load Balancer to the instance in the manage instance group. Also ensure instance can send traffic to each other. Use network tags to allow traffic
5. Make sure you can login via ssh, but do not use bastion host or VPN for it
6. Create load balancer (please choose the most suitable type of load balancer for this purposes  ) with TLS certificate that you created in the task №2 for domain was reserved by you and attach instances as backend to this LB. Read carefully which load balancers are used for different purposes and please prepare couple examples how you may use different type of load balancers in different situations. 
7. Add auto scaling  and auto healing. Configure different metrics and test that they are working(For example you can simulate cpu or ram outage on 1 of the instances, new instance should be created. Or you can switch off internet connection for one of the instances)
    1. All your instances should have Nginx web server running. 
    2. Check that your auto scaling and auto-healing are working correctly. Simulate different situation. 
8. Test that you can reach instances from two mig. Stress out autoscaling and autohealing
9. Check that you’ve got response from different web servers using LB endpoint. Investigate why you got response from different servers and which algorithm are used.

Test that you can reach instances from two mig. Stress out autoscaling and autohealing

### Be ready to answer the following questions:

- Different types of load balancer and when they should be used
- Manage groups, configuration, health checks
- Firewall and firewall rules
- How to generate ssl certificate and attach it to LB
- Autoscaling concepts

https://www.cloudskillsboost.google/course_templates/178/labs/374879

https://www.cloudskillsboost.google/course_templates/178/labs/374887


### !!!!!!!!!!!!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!!!!!!!!!!!!!

### Don’t comment TLS certificates to GitHub 
### Import your TLS certificates from GCP Secret Manager (KMS)


## Stressed test your LB
```
#!/bin/bash
# Created by Google

LB_IP="${YOUR_HTTPS_URL}"
while True ;
do
  ab -n 500000 -c 1000 $LB_IP
done
```