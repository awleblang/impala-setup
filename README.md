Overview
========
A number of Chef cookbooks needed to setup an Impala dev machine. 

Usage
==========

Simply copy the contents of `install.sh` to a local script and run `sudo ./install.sh`. The script 
will install Chef and git, it will clone this repository and finally, it will execute the Impala recipe
(`cookbooks/impala`) to setup the machine. 

Note
==========

Some of the cookbooks require additional modification hacks for compatibility. For exmaple, the java
cookbook originally included dependencies on Windows- and OSX-related cookbooks that had to be removed.
If upgrading any of the cookbooks in this project, be prepared to make similar modificatins. The git
log for this repo should be useful.
