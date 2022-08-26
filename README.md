# EDB Failover Manager - Demo
This project contains the sources for the automatic installation of the EFM environment as well as the description of the EFM demo.

## How to install the demo environment

The EFM environment will be installed in AWS (Cloud) using the tpaexec tool.

**Important**: as the current tpaexec version contains some bugs that make correct EFM configuration impossible, tpaexec version 23.6 should be used, where all these bugs are already fixed.

To test the demo now, you can use tpaexec version 23.3-8-g7096dfa3, which already includes these bug fixes

This version can be obtained from the GutHub and installed according to the following instructions:

```
mkdir /git/projects/
git clone git@github.com:EnterpriseDB/tpaexec.git
cd tpaexec
git pull
git checkout dev/TPA-172-efm-configuration-via-tpaexec-is-not-working
bin/tpaexec info
```

the Output should be:

```
\# TPAexec v23.3-8-g7096dfa3 (branch: dev/TPA-172-efm-configuration-via-tpaexec-is-not-working)
...
```


Now run:

```
tpaexec setup
```

To avoid the error message

```
[WARNING]: Unable to find '/root/git/tpaexec/VERSION' in expected paths (use -vvvvv to see paths)
fatal: detected dubious ownership in repository at '/root/git/tpaexec'
To add an exception for this directory, call:

	git config --global --add safe.directory /root/git/tpaexec
 ```
 
 Run the command:
 
```
git config --global --add safe.directory /root/git/tpaexec
```

Once tpaexec is installed we can deploy the EFM demo.

## Deployment preparation

1. Create the file contained the credentials for the access the EDB YUM Repository
   
   **Important**: Replace EDB-REPO-Username:EDB-REPO-Password with your current username/password

```
echo "EDB-REPO-Username:EDB-REPO-Password" > ~/.edbrepocred
export EDB_REPO_CREDENTIALS_FILE="$HOME/.edbrepocred"
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
export PATH=<Path to the tpaexec binary>:${PATH}
``` 

5. Download this repository

   In my environment I will download the repository to the directory /git/projects

``` 
cd /git/projects
git clone git@github.com:EnterpriseDB/bn-efmdemo-2022.git
cd /git/projects/bn-efmdemo-2022
``` 

5. Edit the file config.yml and replace owner with your Name or E-Mail Address

```
cluster_tags:
  Owner: borys.neselovskyi@enterprisedb.com
```

Now you ready to install and configure the EFM Environment in the AWS

## Deployment

Navigate to the directory with sources, in my example /git/projects/bn-efmdemo-2022.

Run ```tpaexec relink``` to rebuild tpaexec contents

```
cd /git/projects/bn-efmdemo-2022
tpaexec relink .
```

Now run following commands to setup the EFM environment in AWS:

```
tpaexec provision .
tpaexec deploy .
```

If the deploy process ends with the following error message:

```
TASK [pem/agent/config/final : Register PEM agent] *********************************************************************************
fatal: [pg1]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": true}
...ignoring
changed: [pg3]
fatal: [pg2]: FAILED! => {"censored": "the output has been hidden due to the fact that 'no_log: true' was specified for this result", "changed": true}
...ignoring

TASK [pem/agent/config/final : Display stderr from failed agent registration] ******************************************************
fatal: [pg1]: FAILED! => {
    "assertion": "register_cmd is successful",
    "changed": false,
    "evaluated_to": false,
    "msg": "Wed Aug 24 07:01:10 2022 ERROR: ERROR:  tuple concurrently updated"
}
fatal: [pg2]: FAILED! => {
    "assertion": "register_cmd is successful",
    "changed": false,
    "evaluated_to": false,
    "msg": "Wed Aug 24 07:01:10 2022 ERROR: ERROR:  tuple concurrently updated"
}
ok: [pg3] => {
    "changed": false,
    "msg": "All assertions passed"
```

run tpaexec deploy again:

```
tpaexec deploy .
```

## Test the deployment

Navigate to your working directory (in my case: /git/projects/bn-efmdemo-2022) and test the connection to vms pg1, pg2 and pg3:

```
cd /git/projects/bn-efmdemo-2022
ssh -F ssh_config pg1
ssh -F ssh_config pg2
ssh -F ssh_config pg3
```

## Setup the Demo

Run the script ```demo_prep.sh``` and setuo the EFM demo. 

The script creates the table EMP, create some replication slots and changes some efm settings

```
cd /git/projects/bn-efmdemo-2022
chmod 744 demo_prep.sh
chmod -R 744 scripts
./demo_prep.sh
```

Now you are able to run the demo

## Run Demo

see documentation [Demo Script](https://github.com/EnterpriseDB/bn-efmdemo-2022/blob/54bff877829117dd880ee551914a3d57c8096a61/EFM_Demo_AWS_Script.md)
