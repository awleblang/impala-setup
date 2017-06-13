Overview
========
A number of Chef cookbooks needed to setup an Impala dev machine. 

Usage
==========

Simply copy the contents of `install.sh` to a local script and run `sudo ./install.sh`. The script 
will install Chef and git, it will clone this repository and finally, it will execute the Impala recipe
(`cookbooks/impala`) to setup the machine. 
