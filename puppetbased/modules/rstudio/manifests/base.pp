class rstudio::base {
	wget::fetch {"http://download2.rstudio.org/rstudio-server-0.98.507-x86_64.rpm":
		destination => '/tmp/rstudio-server.rpm',
	}
	package {"R-devel":
		require => Class["epel"],
	}

	package {"rstudio-server":
		install_options => ['--nogpgcheck'],
		require => [Class["epel"], Wget::Fetch["http://download2.rstudio.org/rstudio-server-0.98.507-x86_64.rpm"]],
	}	
}
