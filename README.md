# Ubuntu Work Environment
Script to prepare the work environment on Ubuntu.

Rodar:


```bash
git clone https://github.com/raulpacheco2k/Ubuntu-Work-Environment.git
cd Ubuntu-Work-Environment
chmod u+x configure_ubuntu_work_environment.sh
./configure_ubuntu_work_environment.sh
```


Parse the shell with [shellcheck](https://www.shellcheck.net/)



# Curiosities

> The update function is used to resynchronize the package index files from the source.

`sudo apt update`

> The upgrade function tries to gently update the entire system. In this case, any packages that might break the system will not be installed, removed or updated.

`sudo apt upgrade`

> The dist-upgrade function is similar to the upgrade function, however, it removes and installs packages as needed. Usually when we install some software these in turn need their dependencies which are also installed, using dist-upgrade these dependencies will be removed if they are no longer needed.

`sudo apt dist-upgrade`
