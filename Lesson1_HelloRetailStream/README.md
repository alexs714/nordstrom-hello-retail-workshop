# Lesson 1: Create your own local copy of the hello-retail stream.

Goal: In order to prevent resource conflicts between participants, you will have your own copy of the hello-retail kinesis event stream in your account.  Once you've created it, we will begin publishing events to it on the day of the conference using a fan-out lambda function on our core stream.

### Step 1: Refresh your repo

This optional step is recommended to make sure you have the latest code, since we make changes often. Just do a git pull in the root of the repository:

```
git pull
```

This will download the very latest version of the project to your local machine.

### Step 2: Set Up Your Environment

You will need to select a unique `STAGE` name and choose a `REGION` for your service to be deployed into

We recommend you use your User ID to ensure it's unique and to allow you to search for it in the AWS console.  **Do not use a stage name with hyphens in it.**  Please define it as an environment variable for later use:

#### OS X

```sh
export STAGE=<your_unique_id_without_hyphen>
export REGION=us-west-2
```

#### Windows

```bat
set STAGE=<your_unique_id_without_hyphen>
set REGION=us-west-2
```

For the rest of the workshop, the commands will reference `$STAGE`/`%STAGE%` and `$REGION`/`%REGION%` and you will be able to find your components in the AWS console using your stage name.

### Step 3: Customize `private.yml`

Serverless deployments often require information you may not want to check in to a public GitHub repository.  This project contains an example of such a file at `~/private.yml` in the project with the values in the correct format.  These values, needing to be specific to your deployment needs, obviously need to be modified for your circumstance.

In the workshop context, if you are using a shared account, we will provide a working private.yml for you.  If you brought your own account, you will need to customize the first section of what we provide to apply to your account and it's configuration.

### Step 4: Review Your `serverless.yml`

The [Serverless Framework](https://serverless.com/) allows you to create a description of your serverless system in a unified way that supports repeated deployments and iterative improvements over time.  The unit of deployment is called a service.  A single service is represented by and defined with a `serverless.yml` file that declares your serverless components, their configuration, and their relationships to one another.

The `serverless.yml` file for lesson 1 declares a Kinesis Stream that you will deploy and then register with the `hello-retail` system as a place to record all the activity that happens while we use the application.  We'll get into what this is and why it is important but for now we are going to just review and deploy it.

#### OS X

```sh
less <path-to-local-workshop-dir>/Lesson1_HelloRetailStream/ingress-stream/serverless.yml
```

#### Windows

```bat
notepad <path-to-local-workshop-dir>\Lesson1_HelloRetailStream\ingress-stream\serverless.yml
```

Looking at your `serverless.yml`, following the prelude that declares the compatible versions of the serverless framework, loads the `private.yml` file you customized in step 1, and declares some configuration for the framework.  The following section contains resource declarations, defining a `Stream` resource that declares the Kinesis Stream you will deploy and also a `StreamWriter` resource that defines a role that has the rights to describe and put records onto your stream.

This yml file contains the complete definition of resources and services that are deployed as part of your project.

### Step 5: Deploy Your Stream!

#### OS X

```sh
cd <path-to-local-workshop-dir>/Lesson1_HelloRetailStream/ingress-stream
serverless deploy -s $STAGE
```

#### Windows

```bat
cd <path-to-local-workshop-dir>\Lesson1_HelloRetailStream\ingress-stream
serverless deploy -s %STAGE%
```

Once you run the command, you should see that it begins monitoring the progress of your associated CloudFormation stack.  Following the successful deployment of that stack, you should be given a print out of results.

### Step 6: Confirm Your Deployment

Log in to the AWS console, type or find and click on `Kinesis` and then the `Go To Streams console` button.  Type your `$STAGE`/`%STAGE%` value into the filter box and you should see your stream listed there with the format `{stage}Stream`.

Please note that no activity/events will be seen on it until you have registered your stream with our fan-out system and that fan-out system has been attached to our core stream.

### Step 7: Register your Stream and Role

Please use the `/hook-stream` command in the `#serverless-workshop` slack channel to register your complete Kinesis and Role ARNs with the conference organizers.

To find the <stream-kinesis-ARN> for the command below, click the stream that you found in Step 6 in the AWS console. You will find `Stream ARN` under the `Details` tab.

To find the <writer-role-ARN> for the command below, go to the AWS Console home page, and type or find `IAM` and select it.  In the IAM page, go to the `Roles` section and enter your `$STAGE`/`%STAGE%` into the filter to find your `{stage}StreamWriter` role.  Click into that role and the ARN will be displayed for you.


In Slack, using your Kinesis and Role ARNs:
```
/hook-stream <writer-role-ARN> <stream-kinesis-ARN>
```
