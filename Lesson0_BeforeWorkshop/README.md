# Lesson 0: Before the workshop
Goal: Install everything needed for the workshop and confirm that you can login to a public cloud v2 account.

We advise using the native command line tools for your OS.

### Step 1: Clone the Hello-Retail-Workshop repo on your local machine

Go to https://github.com/Nordstrom/hello-retail-workshop and fork our Repo, then clone it locally.

From your workshop directory:

```sh
$ git clone https://github.com/<GitHubID>/hello-retail-workshop.git
```

For more information on using GitHub, go to https://help.github.com/articles/fork-a-repo/

### Step 2: Install node.js

Ensure that you have [Node.js](https://nodejs.org/en/) (v4.3 or later) installed.

If you do not already have NodeJs installed, we suggest using [NVM](https://github.com/creationix/nvm/blob/master/README.markdown) to allow side-by-side install of different node versions.  If you would prefer to install a specific version globally, please download the latest LTS version for your operating system from https://nodejs.org/en/download/.

After successfully installing NodeJs, please run the following script provided at the root directory of this repository in order to check your NodeJS version and install dependencies for your lesson projects.

#### OS X

```sh
./setup-nodejs.sh
```

#### Windows
 
```bat
./setup-win.bat
```

### Step 3: Setup your AWS credentials

```
If you are a Nordstrom Technology engineer, please see the page titled "Serverless Workshop - Nordstrom AWS Credentials Setup" in Confluence and follow the instructions there.
```

Otherwise, install the [AWS-CLI](SETUP-AWS-CLI.md) and use the `aws configure` command to setup your credentials.

Your credentials are located in the AWS Console under:

IAM --> users --> select your user ID --> security credentials tab

If you use any AWS profile other than the default, you'll need to provide that profile name to the environment via the `AWS_PROFILE` variable:

#### OS X
```sh
export AWS_PROFILE=my-profile
```

#### Windows
```bat
set AWS_PROFILE=my-profile
```

### Step 4: install serverless node package on your machine.

#### Note: if you are on a VPN and use a proxy, export your proxy to your shell

#### OS X
```sh
export proxy=https://your.proxy.com:1234
```

#### Windows
```bat
set proxy=https://your.proxy.com:1234
```

Regardless, install the serverless.com deployment framework - this will make it easy to deploy serverless components to AWS

#### OS X or Windows
```sh
npm install -g serverless
```

If you are on OS X and have used sudo to install libraries (and are thereby hitting permissions issues running the above, execute the following: 
`sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}`
