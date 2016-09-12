name             'impala'
maintainer       'Cloudera'
maintainer_email 'dtsirogiannis@cloudera.com'
license          'All rights reserved'
description      'Installs/Configures impala'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "java"
depends "python"
depends "build-essential"
depends "postgresql"
depends "apt"
depends "sudo"
depends "ulimit"
