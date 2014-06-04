class rstudio {
	class {"epel":}
	class {"rstudio::base":}
	package {"git":
		ensure => "installed",
	}
		
}
