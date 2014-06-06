class datascienceprereq {
	class {"basicdev":}
	class {"epel":}
	class {"pip":}
	package {["blas-devel", "lapack-devel"]:}
	package {["python-matplotlib", "python-gtkextra",  "elinks"]:
                require => Class["basicdev"],
        } -> 
	package {"numpy >= 1.8.1":
		provider => "pip",
	} ->
	package {"scipy":
		provider => "pip",
	} ->
	package {["pandas", "openpyxl<2.0.0"]:
		provider => "pip",
	}

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
