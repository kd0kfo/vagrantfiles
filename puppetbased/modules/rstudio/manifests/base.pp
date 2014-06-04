class rstudio::base {
	package {"R-devel":
		require => Class["epel"],
	}

	package {"rstudio-server":
		install_options => ['--nogpgcheck'],
		require => Class["epel"],
	}	
}
