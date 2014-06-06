################################################################################
# FUNCTIONS ####################################################################
################################################################################
define setup_user ($fullname, $myuid, $hash, $shell, $groups) {
    user { "$name":
        uid     => "$myuid",
        comment => "$fullname",
        home    => "/home/$name",
        shell   => $shell,
        groups  => $groups
    }

    exec { "$name homedir":
        command => "cp -R /etc/skel /home/$name; chown -R $name /home/$name",
        path    => "/bin:/usr/sbin",
        creates => "/home/$name",
        require => User[$name],
    }
}

################################################################################
# MAIN #########################################################################
################################################################################

# USER #########################################################################
group { 'admin': }

setup_user { "fabio":
    fullname => "fabio",
    myuid    => 1001,
    hash     => "password",
    shell    => "/bin/bash",
    groups   => [ "admin" ]
}

# SSH Hardening - disable root login and change port ###########################
#augeas { "sshd_config":
# context => "/files/etc/ssh/sshd_config",
#  changes => [
#    "set PermitRootLogin no",
#    "set DebianBanner no",
#    "set Port 1986"
#  ],
#}

# Harden network with sysctl settings ##########################################
#augeas { "sysctl":
#    context => "/files/etc/sysctl.conf",
#    changes => [
#        # IP Spoofing protection
#        "set net.ipv4.conf.all.rp_filter = 1",
#        "set net.ipv4.conf.default.rp_filter = 1",
#        # Ignore ICMP broadcast requests
#        "set net.ipv4.icmp_echo_ignore_broadcasts = 1",
#        # Disable source packet routing
#        "set net.ipv4.conf.all.accept_source_route = 0",
#        "set net.ipv6.conf.all.accept_source_route = 0",
#        "set net.ipv4.conf.default.accept_source_route = 0",
#        "set net.ipv6.conf.default.accept_source_route = 0",
#        # Ignore send redirects
#        "set net.ipv4.conf.all.send_redirects = 0",
#        "set net.ipv4.conf.default.send_redirects = 0",
#        # Block SYN attacks
#        "set net.ipv4.tcp_syncookies = 1",
#        "set net.ipv4.tcp_max_syn_backlog = 2048",
#        "set net.ipv4.tcp_synack_retries = 2",
#        "set net.ipv4.tcp_syn_retries = 5",
#        # Log Martians
#        "set net.ipv4.conf.all.log_martians = 1",
#        "set net.ipv4.icmp_ignore_bogus_error_responses = 1",
#        # Ignore ICMP redirects
#        "set net.ipv4.conf.all.accept_redirects = 0",
#        "set net.ipv6.conf.all.accept_redirects = 0",
#        "set net.ipv4.conf.default.accept_redirects = 0",
#        "set net.ipv6.conf.default.accept_redirects = 0",
#        # Ignore Directed pings
#        "set net.ipv4.icmp_echo_ignore_all = 1"
#    ]
#}
# IP Spoofing protection
exec { 'sysctl-net.ipv4.conf.all.rp_filter':
    command => 'sysctl -w net.ipv4.conf.all.rp_filter = 1'
}
exec { 'sysctl-net.ipv4.conf.default.rp_filter':
    command => 'sysctl -w net.ipv4.conf.default.rp_filter = 1'
}
# Ignore ICMP broadcast requests
exec { 'sysctl-net.ipv4.icmp_echo_ignore_broadcasts':
    command => 'sysctl -w net.ipv4.icmp_echo_ignore_broadcasts = 1'
}
# Disable source packet routing
exec { 'sysctl-net.ipv4.conf.all.accept_source_route':
    command => 'sysctl -w net.ipv4.conf.all.accept_source_route = 0'
}
exec { 'sysctl-net.ipv6.conf.all.accept_source_route':
    command => 'sysctl -w net.ipv6.conf.all.accept_source_route = 0'
}
exec { 'sysctl-net.ipv4.conf.default.accept_source_route':
    command => 'sysctl -w net.ipv4.conf.default.accept_source_route = 0'
}
exec { 'sysctl-net.ipv6.conf.default.accept_source_route':
    command => 'sysctl -w net.ipv6.conf.default.accept_source_route = 0'
}
# Ignore send redirects
exec { 'sysctl-net.ipv4.conf.all.send_redirects':
    command => 'sysctl -w net.ipv4.conf.all.send_redirects = 0'
}
exec { 'sysctl-net.ipv4.conf.default.send_redirects':
    command => 'sysctl -w net.ipv4.conf.default.send_redirects = 0'
}
# Block SYN attacks
exec { 'sysctl-net.ipv4.tcp_syncookies':
    command => 'sysctl -w net.ipv4.tcp_syncookies = 1'
}
exec { 'sysctl-net.ipv4.tcp_max_syn_backlog':
    command => 'sysctl -w net.ipv4.tcp_max_syn_backlog = 2048'
}
exec { 'sysctl-net.ipv4.tcp_synack_retries':
    command => 'sysctl -w net.ipv4.tcp_synack_retries = 2'
}
exec { 'sysctl-net.ipv4.tcp_syn_retries':
    command => 'sysctl -w net.ipv4.tcp_syn_retries = 5'
}
# Log Martians
exec { 'sysctl-net.ipv4.conf.all.log_martians':
    command => 'sysctl -w net.ipv4.conf.all.log_martians = 1'
}
exec { 'sysctl-net.ipv4.icmp_ignore_bogus_error_responses':
    command => 'sysctl -w net.ipv4.icmp_ignore_bogus_error_responses = 1'
}
# Ignore ICMP redirects
exec { 'sysctl-net.ipv4.conf.all.accept_redirects':
    command => 'sysctl -w net.ipv4.conf.all.accept_redirects = 0'
}
exec { 'sysctl-net.ipv6.conf.all.accept_redirects':
    command => 'sysctl -w net.ipv6.conf.all.accept_redirects = 0'
}
exec { 'sysctl-net.ipv4.conf.default.accept_redirects':
    command => 'sysctl -w net.ipv4.conf.default.accept_redirects = 0'
}
exec { 'sysctl-net.ipv6.conf.default.accept_redirects':
    command => 'sysctl -w net.ipv6.conf.default.accept_redirects = 0'
}
# Ignore Directed pings
exec { 'sysctl-net.ipv4.icmp_echo_ignore_all':
    command => 'sysctl -w net.ipv4.icmp_echo_ignore_all = 1'
}
# Make it permanent
exec { 'sysctl -p':
    command => 'sysctl -p'
}

# UTILITY STUFF ################################################################
$utils = [ "byobu", "chkrootkit", "cron-apt", "curl", "dos2unix", "exuberant-ctags", "fail2ban", "git", "htop", "lynx", "make", "puppet", "rkhunter", "sshguard", "vim" ]
package { $utils: ensure => "installed" }

# MUNIN ########################################################################
$munin = [ "munin ", "munin-node", "munin-plugins-extra" ]
package { $munin: ensure => "installed" }

# UFW ########################################################################
$ufw = [ "ufw" ]
package { $ufw: ensure => "installed" }
exec { 'ufw-default':
    command => 'ufw default deny',
    require => [ Package['ufw'] ]
}
exec { 'ufw-ssh':
    command => 'ufw allow ssh',
    require => [ Package['ufw'], Exec['ufw-default'] ]
}
exec { 'ufw-http':
    command => 'ufw allow http',
    require => [ Package['ufw'], Exec['ufw-default'] ]
}
exec { 'ufw-enable':
    command => 'ufw enable',
    require => [ Exec['ufw-ssh'], Exec['ufw-http'] ]
}

# APACHE MODULE ################################################################
package { "apache2":
    ensure => installed,
}

#apache::module { 'actions': }
#apache::module { 'cache': }
#apache::module { 'disk_cache': }
#apache::module { 'expires': }
#apache::module { 'headers': }
#apache::module { 'mem_cache': }
#apache::module { 'rewrite': }
#apache::module { 'ssl': }

# MYSQL MODULE #################################################################
$mysql = [ "mysql-client", "mysql-common", "mysql-server" ]
package { $mysql: ensure => "installed" }

# SQLITE MODULE ################################################################
$sqlite = [ "sqlite3" ]
package { $sqlite: ensure => "installed" }

# PHP MODULE ###################################################################
$php = [ "php5", "php5-curl", "php5-dev", "php5-gd", "php5-imagick", "php5-intl", "php5-mcrypt", "php5-mysql", "php5-sqlite", "php5-xsl" ]
package { $php: ensure => "installed" }

# COMPOSER ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exec { 'composer':
    command => '/usr/bin/curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
    onlyif  => '/bin/bash -c \'exit $(( $( ls /usr/local/bin/composer 2>&1 | wc -l ) ))\'',
    require => [ Package['php5'], Package['curl'] ],
}

$nodejs = [ "nodejs", "npm" ]
package { $nodejs: ensure => "installed" }

# UPDATE PACKAGE LIST ##########################################################
exec { 'update-package-list':
    command => '/usr/bin/sudo apt-get update',
    onlyif  => '/bin/bash -c \'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))\''
}

exec { 'vim-configs':
    command => '/usr/bin/git clone git://github.com/fabiocicerchia/VIM-Configs.git /home/phakko/VIM-Configs && cd /home/phakko/VIM-Configs && git submodule init && git submodule update && ln -s /home/phakko/VIM-Configs/.vimrc /home/phakko/.vimrc && ln -s /home/phakko/VIM-Configs/.vim /home/phakko/.vim && vim +BundleInstall +qall',
    onlyif  => '/bin/bash -c \'exit $(( $( ls /home/phakko/VIM-Configs 2>&1 | wc -l ) ))\'',
    require => [ Package['git'], Package['vim'] ],
}
