This repository contains the sources for the automatic installation of the EFM environment as well as the description of the EFM demo.

The EFM environment is installed with the help of the tpaexec tool.
Important: as the current tpaexec version contains some bugs that make correct EFM configuration impossible, tpaexec version 23.6 should be used, where all these bugs are already fixed.
To test the demo now, you can use tpaexec version 23.3-8-g7096dfa3, which already includes these bug fixes
This version can be obtained from the GutHub and installed according to the following instructions:

git clone git@github.com:EnterpriseDB/tpaexec.git
cd tpaexec
git pull
git checkout dev/TPA-172-efm-configuration-via-tpaexec-is-not-working
bin/tpaexec info
\# TPAexec v23.3-8-g7096dfa3 (branch: dev/TPA-172-efm-configuration-via-tpaexec-is-not-working)
tpaexec=bin/tpaexec
TPA_DIR=/Users/borysneselovskyi/git/ttt/tpaexec
PYTHON=/Users/borysneselovskyi/.pyenv/shims/python3 (v3.9.13, no venv)
TPA_VENV=none (did you run tpaexec setup?)
ANSIBLE=none (won't use /usr/local/bin/ansible; run tpaexec setup)
