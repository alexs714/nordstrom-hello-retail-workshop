# Lesson 0: Before the workshop
Goal: Install everything needed for the workshop and confirm that you can login to a public cloud v2 account.

We advise using the native command line tools for your OS.

### Step 1: Clone the Hello-Retail-Workshop repo on your local machine

Go to https://github.com/Nordstrom/hello-retail-workshop and clone it locally:

```sh
$ git clone https://github.com/Nordstrom/hello-retail-workshop.git
```

If you would like to provide fixes or changes to the workshop, please [fork the repository](https://help.github.com/articles/fork-a-repo/) and submit a [pull request](https://help.github.com/articles/creating-a-pull-request-from-a-fork/).

### Step 2: Install node.js and run script

Ensure that you have [Node.js](https://nodejs.org/en/) (v4.3 or later) installed.

If you do not already have NodeJs installed, we suggest using [NVM](https://github.com/creationix/nvm#installation) to allow side-by-side install of different node versions.  If you would prefer to install a specific version globally, please download the latest LTS version for your operating system from https://nodejs.org/en/download/.

After successfully installing NodeJs, please run the following script provided at the root directory of this repository in order to check your NodeJS version and install dependencies for your lesson projects.

#### OS X

```sh
./setup-nodejs.sh
```

#### Windows
 
```bat
setup-win.bat
```

### Step 3: Setup your AWS credentials

> **_NOTE: Nordstrom Technology!_**
>
> If you are a _Nordstrom_ engineer, please ignore this step and instead see the page titled _`Serverless Workshop - Nordstrom Technology Setup`_ in **Confluence** and follow the instructions there.


Install the [AWS-CLI](SETUP-AWS-CLI.md) and use the `aws configure` command to setup your credentials.

Your credentials are located in the AWS Console under:

IAM --> users --> select your user ID --> security credentials tab

If you use any AWS profile other than the default, you'll need to provide that profile name to the environment via the `AWS_PROFILE` variable:

#### OS X
```sh
export AWS_PROFILE=<your-profile>
```

#### Windows
```bat
set AWS_PROFILE=<your-profile>
```

### Step 4: install serverless node package on your machine.

Install the serverless.com deployment framework - this will make it easy to deploy serverless components to AWS.

#### OS X or Windows
```sh
npm install -g serverless@1.11.0
```

If you are on OS X and have used sudo to install libraries (and are thereby hitting permissions issues running the above, execute the following: 
`sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}`
