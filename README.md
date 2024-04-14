# Terraform manifests
## First task №1
### Manually

> 1. Set up your GCP account 
> 2. Read documentation about free tier(that will be useful for you for saving money)
> 3. Read GCP documentation about Compute Engine instances
> 4. Create VPC with custom subnet in Frankfurt region in C ip range class
> 5. Create firewall rule only for 80 http port, create tag to assign to GCE instance
> 6. Set up GCE instance and install nginx web server on it, assign network tag to this machine
> 7. Create machine image from this instance and set up additional GCE instance from this MI
> 8. Web server should be up and running at the start of new instance.
> 9. Web server should have static IP address and this address shouldn’t be changed after reboot

### Half-automation

> 1. Build GCP Machine Image using Packer and Bash as a provision tool, install nginx proxy-web-server on it with static html page different from basic
> 2. Create GCE instance with static IP from this image
> 3. Test instancing stop and start to check if instance do not lose static IP after reboot

### Terraform

> 1. Create VPC with custom subnet in Frankfurt region in C ip range class
> 2. Create firewall rule only for 80 http port, create tag to assign to GCE instance
> 3. Create GCE instance from Machine image you create on previous task, assign network tag to this machine
> 4. Assign static IP for machine