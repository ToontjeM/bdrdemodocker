# EDB Failover Manager - Demo (WIP - Work in Progress...)
This project contains the sources for the automatic installation of the EFM environment as well as the description of the EFM demo.

## How to install the demo environment

The EFM environment will be installed in AWS (Cloud) using the tpaexec tool.

**Important**: as the current tpaexec version contains some bugs that make correct EFM configuration impossible, tpaexec version 23.6 should be used, where all these bugs are already fixed.

To test the demo now, you can use tpaexec version 23.3-8-g7096dfa3, which already includes these bug fixes

This version can be obtained from the GutHub and installed according to the following instructions:

```
git clone git@github.com:EnterpriseDB/tpaexec.git
cd tpaexec
git pull
git checkout dev/TPA-172-efm-configuration-via-tpaexec-is-not-working
bin/tpaexec info
```

the Output should be:
```
\# TPAexec v23.3-8-g7096dfa3 (branch: dev/TPA-172-efm-configuration-via-tpaexec-is-not-working)
tpaexec=bin/tpaexec
TPA_DIR=xxxxxxxx/tpaexec
PYTHON=xxxxxxx/python3 (v3.9.13, no venv)
TPA_VENV=none (did you run tpaexec setup?)
ANSIBLE=none (won't use /usr/local/bin/ansible; run tpaexec setup)
```
Now run:

```
tpaexec setup
```

Once tpaexec is installed we can deploy the EFM demo.

## Deployment preparation

1. Create the file contained the credentials for the access the EDB YUM Repository
   
   **Important**: Replace EDB-REPO-Username:EDB-REPO-Password with your current username/password

```
echo "EDB-REPO-Username:EDB-REPO-Password" > ~/.edbrepocred
```

2. Enable any 2ndQuadrant repositories and set the variable

```
export TPA_2Q_SUBSCRIPTION_TOKEN=<your token>
```

3. Obtain the AWS Credentials to accessing the AWS and to create the EFM VMs, then export following variables

```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
```

4. Include the binary tpaexec in the PATH Variable

   For example:
   
 ```
export PATH=<Path to the rpaexec binary>:${PATH}
``` 

5. Download this repository, for example


