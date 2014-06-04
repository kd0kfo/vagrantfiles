node default {
	class {"rstudio":}
	class {"ipython":}

	file {"/etc/motd":
		content => "This is a server with Data Science Tools build using Vagrant and Puppet",
		ensure => present,
	}
}
