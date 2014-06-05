class rstudio::base {
	wget::fetch {"http://download2.rstudio.org/rstudio-server-0.98.507-x86_64.rpm":
		destination => '/tmp/rstudio-server.rpm',
	}
	package {"R-devel":
		require => [Class["epel"], Package["blas-devel"], Package["lapack-devel"]],
	}

	exec {"yum localinstall -y --nogpgcheck /tmp/rstudio-server.rpm":
		path => "/usr/bin:/usr/sbin:/bin",
		require => [Class["epel"], Wget::Fetch["http://download2.rstudio.org/rstudio-server-0.98.507-x86_64.rpm"]],
		unless => "which rstudio-server",
	}	

	file {"/etc/init.d/rstudio-server":
		source => "/usr/lib/rstudio-server/extras/init.d/redhat/rstudio-server",
		require => Exec ["yum localinstall -y --nogpgcheck /tmp/rstudio-server.rpm"],
		ensure => present,
	}
}
