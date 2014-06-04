node default {
	class {"basicdev":}
	class {"epel":}
	class {"pip":}
	package {["blas-devel", "lapack-devel"]:}
	class {"rstudio::base":}
	class {"ipython::base":}

	file {"/etc/motd":
		content => "This is a server with Data Science Tools build using Vagrant and Puppet",
		ensure => present,
	}
}
