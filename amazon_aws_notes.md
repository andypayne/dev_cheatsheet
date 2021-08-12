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

Also see [Amazon's documentation](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/configuring-https-elb.html).

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
OR, add a bucket policy that allows anyone to read objects from this S3 bucket:
```json
{
    "Id": "ExampleComAllowPublicAccess",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::bucket.example.com/*"
            ]
        }
    ]
}
```
6. Go to `Properties -> Static website hosting`. Enable this option, and select `Host a static website`.
7. Set the proper `Index document` (`index.html`).
8. In order to support client-side routing, the `Error document` should also be set to the same root document (`index.html`).


#### 2. Create a Distribution in CloudFront

__Note:__ See step #11 below about registering an SSL certificate, since that may need to be completed first.

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
11. Select the `SSL Certificate` that you are using. If you need a custom certificate and haven't created one yet, you will probably have to restart the CloudFront distribution creation process after creating a custom certificate with [AWS Certificate Manager (ACM)](https://aws.amazon.com/certificate-manager/). If you have a certificate for your domain that you created with another service, you may need to import it into ACM to use it. Also note that ACM manages certificates in multiple regions, and according to [Amazon docs](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cnames-and-https-requirements.html#https-requirements-aws-region), you must use the `US East (N. Virginia)` region for your certificate for use with Cloudfront: "If you want to require HTTPS between viewers and CloudFront, you must change the AWS Region to US East (N. Virginia) in the AWS Certificate Manager console before you request or import a certificate. If you want to require HTTPS between CloudFront and your origin, and you're using an ELB load balancer as your origin, you can request or import a certificate in any Region."
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

With the [AWS command line tool](https://aws.amazon.com/cli/):

```shell
aws s3 sync build/ s3://proj.example.com --delete
```

Then probably create an invalidation in CloudFront.

Here's more info on [configuring the AWS command line tool](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).


## Elastic Container Service (ECS)

*TODO:* Write up a consolidated policy granting all the necessary permissions.

### Install AWS Copilot

- [AWS Copilot](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Copilot.html)
- [Getting started with Amazon ECS using AWS Copilot](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-aws-copilot-cli.html)

```shell
sudo curl -Lo /usr/local/bin/copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-darwin && sudo chmod +x /usr/local/bin/copilot && copilot --help
```

### Deploy the sample app

```shell
git clone https://github.com/aws-samples/amazon-ecs-cli-sample-app.git demo-app && \
cd demo-app && copilot init --app demo --name api --type 'Load Balanced Web Service' --dockerfile './Dockerfile' --port 80 --deploy
```

### Adding permissions

Two errors may be encountered with your user:

ssn:GetParameter permission error:
```
AccessDeniedException: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: ssm:GetParameter on resource: ...
```

cloudformation:DescribeStacks permission error:
```
AccessDeniedException: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: cloudformation:DescribeStacks on resource: ...
```

Add these two policies to your user account in IAM:

- AmazonSSMFullAccess
- AWSCloudFormationFullAccess

### Docker Errors

```shell
git clone https://github.com/aws-samples/amazon-ecs-cli-sample-app.git demo-app && \
cd demo-app && copilot init --app demo --name api --type 'Load Balanced Web Service' --dockerfile './Dockerfile' --port 80 --deploy
Cloning into 'demo-app'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 12 (delta 1), reused 5 (delta 0), pack-reused 0
Unpacking objects: 100% (12/12), done.
zsh: command not found:
Welcome to the Copilot CLI! We're going to walk you through some questions
to help you get set up with a containerized application on AWS. An application is a collection of
containerized services that operate together.

Ok great, we'll set up a Load Balanced Web Service named api in application demo listening on port 80.

✘ Failed to create the infrastructure to manage services and jobs under application demo.

✘ execute app init: wait until stack demo-infrastructure-roles create is complete: ResourceNotReady: failed waiting for successful resource state
```

Running through the individual process steps showed that the local docker daemon was not running:
```
Docker daemon is not responsive; Copilot won't build from a Dockerfile.
```

Running `docker info` confirmed this:
```shell
docker info -f '{{json . }}'
{"ServerErrors":["Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?"],"ClientInfo":{"Debug":false,"Plugins":[],"Warnings":null}}
```

So [start the docker daemon](https://docs.docker.com/config/daemon/).

Then `docker info`:
```shell
docker info -f '{{json . }}'
{"ID":"ABCD:...","Containers":0,"ContainersRunning":0,"ContainersPaused":0,"ContainersStopped":0,"Images":0,"Driver":"overlay2","DriverStatus":[["Backing Filesystem","extfs"],["Supports d_type","true"], ...}
```

### Deploy Errors

The deployment still failed with:
```
copilot init --app demo --name api --type 'Load Balanced Web Service' --dockerfile './Dockerfile' --port 80 --deploy

Welcome to the Copilot CLI! We're going to walk you through some questions
to help you get set up with a containerized application on AWS. An application is a collection of
containerized services that operate together.

Ok great, we'll set up a Load Balanced Web Service named api in application demo listening on port 80.

✘ Failed to create the infrastructure to manage services and jobs under application demo.

✘ execute app init: wait until stack demo-infrastructure-roles create is complete: ResourceNotReady: failed waiting for successful resource state
```

I went to CloudFormation and found the stack and deleted it. After rerunning the `copilot init` command, I still get the same error.

Looking in the Stack details in CloudFormation (Stack -> Events), there is another permission error:
```
API: iam:GetRole User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: iam:GetRole on resource: role demo-adminrole
```

I added the `IAMReadOnlyAccess` permission to my user account in IAM and ran again.

This time CloudFormation shows a new permission error:
```
API: iam:CreateRole User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: iam:CreateRole on resource: arn:aws:iam::909724554299:role/demo-adminrole
```

So I added the `IAMFullAccess` permission and ran again.

This time there were no errors in the initial CloudFormation events, and the process made it further. But then it failed with more errors:
```shell
copilot init --app demo --name api --type 'Load Balanced Web Service' --dockerfile './Dockerfile' --port 80 --deploy
Welcome to the Copilot CLI! We're going to walk you through some questions
to help you get set up with a containerized application on AWS. An application is a collection of
containerized services that operate together.

Ok great, we'll set up a Load Balanced Web Service named api in application demo listening on port 80.

✔ Created the infrastructure to manage services and jobs under application demo..

✔ Wrote the manifest for service api at copilot/api/manifest.yml
Your manifest contains configurations like your container size and port (:80).

✔ Created ECR repositories for service api..


✔ Linked account 909724554299 and region us-west-2 to application demo..

✔ Proposing infrastructure changes for the demo-test environment.
- Creating the infrastructure for the demo-test environment.                         [rollback complete]  [172.9s]
  The following resource(s) failed to create: [InternetGateway, Cluster,
   VPC]. Rollback requested by user.
  - An IAM Role for AWS CloudFormation to manage resources                           [not started]
  - An ECS cluster to group your services                                            [delete complete]    [0.0s]
    Resource creation cancelled
  - Enable long ARN formats for the authenticated AWS principal                      [not started]
  - An IAM Role to describe resources in your environment                            [not started]
  - A security group to allow your containers to talk to each other                  [not started]
  - An Internet Gateway to connect to the public internet                            [delete complete]    [0.0s]
    API: ec2:CreateInternetGateway You are not authorized to perform this
    operation. Encoded authorization failure message: rFesh...
  - Private subnet 1 for resources with no internet access                           [not started]
  - Private subnet 2 for resources with no internet access                           [not started]
  - Public subnet 1 for resources that can access the internet                       [not started]
  - Public subnet 2 for resources that can access the internet                       [not started]
  - A Virtual Private Cloud to control networking of your AWS resources              [delete complete]    [0.0s]
    API: ec2:CreateVpc You are not authorized to perform this operation. E
    ncoded authorization failure message: OKk-Ia8PA_mlTDWXTupzLo2QYz3JaVCS
    UPgy9XkNm-gRymx8tHObROoauSl6PA0QWv4Is6BIAMV9Ymn-44PdkXjGmODgbPRt-Rs_jz
    9qGfJyiZfwVBcfGUo1nFG07G059vN4Y57X0owHltEG4Rl3VgB3bgtdbilOOYStty6V5Wbw
    4ZvhL6OldwEiahIblZjewu-WF3IsvOABte2iwkNwc7h_eMvVYajLp3gwqIf3e-0M9fahBf
    9lPgDalXCM39XIyWTp_cvetx1WQ6JniBoQc-YxEYy2YyxMFcIaiSlJcSZul7o49BQmaySv
    t-goxShWW4WNqTcliv1vUmdmna_lI2ayzjDm1y0tdZlav7LLp8w6oXS7VdQgew8Rurhqdx
    acYh4LdvRf8CklrirmJWSKn6pPWE-_x-PakFSJAXetmKyWapIlUWzOR2C3BB_7T5TiFAlK
    vbxwH13GrWjJLdnRCRLL7fL9JjmxnM_imuUAi2qkTwz5nuEw0njbDCCvSYT6Vs3YTsWC
✘ stack demo-test did not complete successfully and exited with status ROLLBACK_COMPLETE
```


CloudFormation shows other errors, including:
```
API: ec2:CreateInternetGateway You are not authorized to perform this operation. ...
```

and:
```
API: ec2:CreateVpc You are not authorized to perform this operation. ...
```

But trying to add the `AmazonEC2FullAccess` permission failed, because of a policy limit:
```
Limit exceeded
Your request exceeds one of the limits for this account. Remove one or more existing items and try again. Learn more
Cannot exceed quota for PoliciesPerUser: 10
```

So I had to remove some policies and add `AmazonEC2FullAccess`.

Rerunning results in another permission error:
```
User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: ecs:DescribeClusters on resource: ...
```

So I added the `AmazonECS_FullAccess` permission. Rerunning results in yet another permission error:

```
User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: servicediscovery:TagResource on resource: ...
```

So I added the `AWSCloudMapFullAccess` permission and reran. Of course there was another permission error:

```
User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: lambda:CreateFunction on resource: ...
```

So I added the `AWSLambda_FullAccess` permission and reran. I think it's getting
closer. Now another permission error:

```
✘ initiate image builder pusher: get repository URI: ecr describe repository demo/api: AccessDeniedException: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: ecr:DescribeRepositories on resource: ...
```

So I added the `AmazonElasticContainerRegistryPublicFullAccess` permission and tried again. That resulted in the same error, so it must hae been the wrong permission.


Next I noticed that there was an existing custom policy that appeared to cover this, so I added it. The policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:DescribeImages",
                "ecr:GetAuthorizationToken",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetRepositoryPolicy"
            ],
            "Resource": "*"
        }
    ]
}
```

Rerunning resulted in another permission error:
```
AccessDenied: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: sts:AssumeRole on resource: ...
```

So I added this permission to the policy:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:DescribeImages",
                "ecr:GetAuthorizationToken",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetRepositoryPolicy",
                "sts:AssumeRole"
            ],
            "Resource": "*"
        }
    ]
}
```

Rerun. So close. Another one:

```
denied: User: arn:aws:iam::123567890:user/my-user-name is not authorized to perform: ecr:InitiateLayerUpload on resource: ...
```

So I added `ecr:InitiateLayerUpload` to the policy. Rerun. It never ends:

```
denied: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: ecr:UploadLayerPart on resource: ...
```

Add `ecr:UploadLayerPart` to the policy. Rerun. Another:
```
denied: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: ecr:CompleteLayerUpload on resource: ...
```

Add `ecr:CompleteLayerUpload` to the policy. Rerun. Another:
```
denied: User: arn:aws:iam::1234567890:user/my-user-name is not authorized to perform: ecr:PutImage on resource: ...
```

Add `ecr:PutImage` to the policy. Rerun. Success.

```shell
copilot app ls
demo
```

```shell
copilot app show
About

  Name              demo
  Version           v1.0.2
  URI

Environments

  Name              AccountID           Region
  ----              ---------           ------
  test              909724554299        us-west-2

Services

  Name              Type
  ----              ----
  api               Load Balanced Web Service

Pipelines

  Name
  ----

```

```shell
copilot env ls
test
```

```shell
copilot env show
Only found one environment, defaulting to: test
About

  Name              test
  Production        false
  Region            us-west-2
  Account ID        909724554299

Services

  Name              Type
  ----              ----
  api               Load Balanced Web Service

Tags

  Key                  Value
  ---                  -----
  copilot-application  demo
  copilot-environment  test

```

```shell
copilot svc ls
Name                Type
----                ----
api                 Load Balanced Web Service
```

```shell
copilot svc status
Found only one deployed service api in environment test
Task Summary

  Running   ██████████  1/1 desired tasks are running
  Health    ██████████  1/1 passes HTTP health checks

Tasks

  ID        Status      Revision    Started At    HTTP Health
  --        ------      --------    ----------    -----------
  d4939655  RUNNING     1           11 hours ago  HEALTHY
```

```shell
copilot svc logs
Found only one deployed service api in environment test
copilot/api/d4939655fda94 10.0.0.33 - - [11/Aug/2021:15:39:59 +0000] "GET / HTTP/1.1" 200 3165 "-" "ELB-HealthChecker/2.0" "-"
copilot/api/d4939655fda94 10.0.1.194 - - [11/Aug/2021:15:40:00 +0000] "GET / HTTP/1.1" 200 3165 "-" "ELB-HealthChecker/2.0" "-"
copilot/api/d4939655fda94 10.0.0.33 - - [11/Aug/2021:15:40:29 +0000] "GET / HTTP/1.1" 200 3165 "-" "ELB-HealthChecker/2.0" "-"
copilot/api/d4939655fda94 10.0.1.194 - - [11/Aug/2021:15:40:30 +0000] "GET / HTTP/1.1" 200 3165 "-" "ELB-HealthChecker/2.0" "-"
copilot/api/d4939655fda94 10.0.0.33 - - [11/Aug/2021:15:40:59 +0000] "GET / HTTP/1.1" 200 3165 "-" "ELB-HealthChecker/2.0" "-"
```


### Amazon ECS using the AWS CDK

Article: [Getting started with Amazon ECS using the AWS CDK](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/tutorial-ecs-web-server-cdk.html)

```shell
npm install -g aws-cdk
```

```shell
cdk init --language python
```

```shell
source .venv/bin/activate
```

```shell
pip install -U pip
```

```shell
python -m pip install -r requirements.txt
```

```shell
python -m pip install aws-cdk.aws-ecs-patterns
```

Available for importing:
```
aws_cdk.aws_ecs
aws_cdk.aws_ecs_patterns
```

Edit `hello_ecs/hello_ecs_stack.py`.

```shell
cdk synth
```

```shell
cdk deploy
```


