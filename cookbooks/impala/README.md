impala Cookbook
===============
This cookbook configures a machine for Impala development. 

Platform
------------
* Ubuntu 14.04
* Ubuntu 12.04 (under development)
* Centos 6 (under development)
* Centos 7 (under development)

Usage
-----
#### impala::default

Just include `impala` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[impala]"
  ]
}
```

License and Authors
-------------------
Authors: Dimitris Tsirogiannis (dtsirogiannis@cloudera.com)
