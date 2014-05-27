class devbox {
	class {"basicdev":}
	package {["python", "python-devel", "vim-enhanced", "emacs", "elinks"]:
		require => Class["basicdev"]
	}

	class {"pip":}
}

node default {
	package {["vim-enhanced", "emacs", "elinks"]:}

	file {"/etc/motd":
		content => "Build using Vagrant and Puppet\n",
	}

}

node devbox {
	class {"devbox":}

	file {"/etc/motd":
		content => "This is a development machine made using Vagrant and Puppet\n",
	}
}

class ipython {
	
	class {"basicdev":}
	package {["python", "python-devel", "python-matplotlib", "python-gtkextra", "vim-enhanced", "emacs", "elinks"]:
		require => Class["basicdev"],
	}
	class {"pip":}

	group {"ipython":
		system => true,
		ensure => present,
	}

	user {"ipython":
		ensure => present,
		gid => "ipython",
		managehome => true,
		require => Group["ipython"],
	}	

	file {"/etc/init.d/ipython":
		ensure => file,
		replace => false,
		owner => "root",
		group => "root",
		mode => 0744,
		source => "puppet:///modules/files/etc/init.d/ipython",
	}

	package {["pygments", "tornado", "jinja2", "Cython"]:
		provider => "pip",
		require => Class["pip"],
	}
	package {"numpy >= 1.8.1":
		provider => "pip",	
		require => [Class["pip"], Package["blas-devel"], Package["lapack-devel"]],
	}
	package {"scipy":
		provider => "pip",
		require => Package["numpy >= 1.8.1"],
	}

	package {"pandas":
		provider => "pip",
		require => Package["scipy"],
	}

	github::clone {"ipython":
		projectname => "ipython/ipython",
	}

	github::checkout {"ipython rel-1.2.1":
		project => "ipython",
		branch => "rel-1.2.1",
		require => Github::Clone["ipython"], 
	}

	github::install {"ipython":
		project => "ipython",
		require => Github::Checkout["ipython rel-1.2.1"],
		unless => "which ipython",
	}

	github::clone {"zeromq/pyzmq":
		projectname => "zeromq/pyzmq",
		require => Package["Cython"],
	} ->
	github::install {"zeromq/pyzmq":
		project => "pyzmq",
		unless => "pip freeze |grep zmq",
		require => Class["pip"],
	}

}

node "ipython", /ipython\..+/ {
	class {"ipython":}
	
	file {"/etc/motd":
		content => "This is an ipython notebook server made using Vagrant and Puppet\n"
	}

}


