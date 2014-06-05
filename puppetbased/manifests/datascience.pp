class datascienceprereq {
	class {"basicdev":}
	class {"epel":}
	class {"pip":}
	package {["blas-devel", "lapack-devel"]:}
}

node default {
	class {"datascienceprereq":}
	class {"rstudio::base":
		require => Class["datascienceprereq"],
	}
	class {"ipython::base":
		require => Class["datascienceprereq"],
	}

	file {"/etc/motd":
		content => "This is a server with Data Science Tools build using Vagrant and Puppet",
		ensure => present,
	}
}
