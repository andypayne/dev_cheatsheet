# Notes on Amazon Web Services (AWS)

## Elastic Beanstalk

### Install the `eb` command line tools

Instructions: [Install the EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html), which will probably send you to the [elastic beanstalk github repo](https://github.com/aws/aws-elastic-beanstalk-cli-setup) to clone and install from there.

To avoid the installation attempting to download and install its own python stack, specify the location of your python installation (as mentioned in [Advanced use](https://github.com/aws/aws-elastic-beanstalk-cli-setup#3-advanced-use):

```shell
python scripts/ebcli_installer.py --python-installation /opt/anaconda3/bin/python
```


### Create an environment for a git repo

#### 0. Run `eb init` in the project if it hasn't been done.

Select the region, the project name, the application (or create a new one), and whether you want ssh enabled.


#### 1. Add an .npmrc file (for node.js projects)

When running `eb create` (below) you may get errors like this:

```
2020-10-15 22:32:13    INFO    createEnvironment is starting.
2020-10-15 22:32:14    INFO    Using elasticbeanstalk-us-west-2-123 as Amazon S3 storage bucket for environment data.
2020-10-15 22:32:35    INFO    Created security group named: sg-123abc
2020-10-15 22:32:35    INFO    Created load balancer named: awseb-e-2-AWSEBLoa-123ABC456
2020-10-15 22:32:52    INFO    Created security group named: awseb-e-123-stack-AWSEBSecurityGroup-ABC
2020-10-15 22:32:52    INFO    Created Auto Scaling launch configuration named: awseb-e-123-stack-AWSEBAutoScalingLaunchConfiguration-ABC
2020-10-15 22:33:39    INFO    Created Auto Scaling group named: awseb-e-123-stack-AWSEBAutoScalingGroup-ABC
2020-10-15 22:33:39    INFO    Waiting for EC2 instances to launch. This may take a few minutes.
2020-10-15 22:33:54    INFO    Created Auto Scaling group policy named:
arn:aws:autoscaling:us-west-2:1234:scalingPolicy:123-abc:autoScalingGroupName/awseb-e-123-stack-AWSEBAutoScalingGroup-ABC:policyName/awseb-e-123-stack-AWSEBAutoScalingScaleUpPolicy-ABC
2020-10-15 22:33:54    INFO    Created Auto Scaling group policy named:
arn:aws:autoscaling:us-west-2:123:scalingPolicy:abc:autoScalingGroupName/awseb-e-123-stack-AWSEBAutoScalingGroup-ABC:policyName/awseb-e-123-stack-AWSEBAutoScalingScaleDownPolicy-ABC
2020-10-15 22:33:54    INFO    Created CloudWatch alarm named:
awseb-e-123-stack-AWSEBCloudwatchAlarmHigh-ABC
2020-10-15 22:33:54    INFO    Created CloudWatch alarm named:
awseb-e-123-stack-AWSEBCloudwatchAlarmLow-ABC
2020-10-15 22:33:58    INFO    Instance deployment: You didn't specify a Node.js version in the 'package.json' file in your source bundle. The deployment didn't install a specific Node.js version.
2020-10-15 22:34:13    ERROR   Instance deployment failed. For details, see 'eb-engine.log'.
2020-10-15 22:34:13    ERROR   Instance deployment: 'npm' failed to install dependencies that you defined in 'package.json'. For details, see
'eb-engine.log'. The deployment failed.
2020-10-15 22:34:14    ERROR   [Instance: i-abc123] Command failed on instance. Return code: 1 Output: Engine execution has encountered an error..
2020-10-15 22:34:14    INFO    Command execution completed on all instances. Summary: [Successful: 0, Failed: 1].
2020-10-15 22:35:16    ERROR   Create environment operation is complete, but with errors. For more information, see troubleshooting documentation.
ERROR: ServiceError - Create environment operation is complete, but with errors.
For more information, see troubleshooting documentation.
```

If so, then here's a workaround:
1.  Create a `.npmrc` file in the project root:
```
# Force npm to run node-gyp as root
unsafe-perm=true
```
2. Check the file into git
3. Then proceed with `eb create` as below.

More info is in this [Stack Overflow thread](https://stackoverflow.com/questions/46001516/beanstalk-node-js-deployment-node-gyp-fails-due-to-permission-denied).


#### 2. Run `eb create`

```shell
$ eb create

Enter Environment Name
(default is foo-bar-env):
Enter DNS CNAME prefix
(default is foo-bar-env): yoyo

Select a load balancer type
1) classic
2) application
3) network
(default is 2): 1


Would you like to enable Spot Fleet requests for this environment?
(y/N): n
Creating application version archive "app-xxxx-987654_123456".
Uploading: [##################################################] 100% Done...
Environment details for: yoyo
  Application name: my-git-proj
  Region: us-west-2
  Deployed Version: app-xxxx-987654_123456
  Environment ID: e-xyzqrstuvw
  Platform: arn:aws:elasticbeanstalk:us-west-2::platform/Node.js running on 64bit Amazon Linux/4.8.1
  Tier: WebServer-Standard-1.0
  CNAME: yoyo.us-west-2.elasticbeanstalk.com
  Updated: 2020-07-12 13:15:00.000000+00:00

Printing Status:
...
```


#### 3. Modify the load balancer to support HTTPS traffic

To support HTTPS traffic externally and route it to the listener using HTTP:

1. Go to the Elastic Beanstalk web console and configure the load balancer.
2. Disable the listener for port 80.
3. Add a listener for port 443 with listener protocol HTTPS and instance protocol HTTP.
4. Select the appropriate SSL certificate for the domain you want to redirect to this environment.
5. Enable session stickiness.
6. Modify the load balancer listener ports to be 443 only.
7. Click `Apply` to save the settings and update the environment.


#### 4. Create the DNS record in Route 53

1. In Route 53, create a new record set.
2. Type in a hostname and select type `A - IPv4 address`.
3. Select 'yes' for Alias.
4. In the `Alias Target` field, select the name of the newly created Elastic Beanstalk environment.
5. Save the record set.


## S3 and CloudFront

### Create a bucket for a web app for access with HTTPS

We'll use CloudFront to achieve SSL support.

#### 1. Create and configure a new bucket

1. Create a new bucket in the S3 web console.
2. Enter the hostname as the bucket name.
3. For permissions, turn off `Block all public access` (since we're hosting a publicly-accessible web app).
4. Edit the bucket -- under `Permissions -> Access Control List -> Public access`, grant permission `List objects` to group `Everyone`.
5. Under `Bucket Policy`, add a policy that grants access to the CloudFront user:
```json
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity X1F723G45ZBGM7"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::proj.example.com/*"
        }
    ]
}
```
6. Go to `Properties -> Static website hosting`, and select `Use this bucket to
   host a website`.
7. Set the proper `Index document` (`index.html`).
8. In order to support client-side routing, the `Error document` should also be set to the same root document (`index.html`).


#### 2. Create a Distribution in CloudFront

1. In CloudFront, click `Create Distribution`.
2. Under `Web`, select `Get Started`.
3. For `Origin Domain Name`, select the name of the S3 bucket created previously.
4. Enable `Restrict Bucket Access` to require accessing the bucket through CloudFront.
5. Select or create an identity to use to access the bucket.
6. Select `Grant Read Permissions on Bucket` to let CloudFront grant permissions for this identity.
7. Under `Default Cache Behavior Settings`, for `Viewer Protocol Policy`, select `Redirect HTTP to HTTPS` to enforce usage on HTTPS.
8. Select the allowed HTTP verbs you want to use.
9. For `Forward Cookies`, select `All` if needed.
10. Under `Distribution Settings`, for `Alternate Domain Names (CNAMEs)`, add the public-facing domain name(s) you are using.
11. Select the `SSL Certificate` that you are using. If you need a custom certificate and haven't created one yet, you will probably have to restart the CloudFront distribution creation process after creating a custom certificate with `ACM`.
12. For `Default Root Object`, add your root file (`index.html`).
13. Click `Create Distribution`.
14. Edit the distribution - under `Error Pages`, select `Create Custom Error Response`.
15. Select `HTTP Error Code` of `404: Not Found`.
16. Select `Customize Error Response`.
17. For `Response Page Path`, enter the path to the root document (`/index.html`).
18. For `HTTP Response Code`, select `200: OK`.


#### 3. Configure the hostname in Route 53

Create a new record set of type `A` with an `Alias` with target pointing to the CloudFront distribution just created.


#### 4. Deploy

With the AWS command line tool:

```shell
aws s3 sync build/ s3://proj.example.com --delete
```

Then probably create an invalidation in CloudFront.


