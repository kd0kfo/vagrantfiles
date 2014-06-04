class ipython {
	
	class {"basicdev":}
	package {["python", "python-devel", "python-matplotlib", "python-gtkextra", "vim-enhanced", "emacs", "elinks"]:
		require => Class["basicdev"],
	}
	
	package {["blas-devel", "lapack-devel"]:}

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
		source => "puppet:///modules/ipython/etc/init.d/ipython",
	}

	package {["pygments", "tornado", "jinja2", "Cython"]:
		provider => "pip",
		require => Class["pip"],
	}
	package {"numpy >= 1.8.1":
		provider => "pip",	
		require => [Class["pip"], Package["blas-devel"], Package["lapack-devel"], Package['python-devel']],
	}
	package {"scipy":
		provider => "pip",
		require => Package["numpy >= 1.8.1"],
	}

	package {"pandas":
		provider => "pip",
		require => Package["scipy"],
	}

	vcsrepo {"/usr/src/ipython":
		ensure => present,
		provider => git,
		source => "https://github.com/ipython/ipython.git",
		revision => "rel-1.2.1",
	}

	vcsrepo {"/usr/src/pyzmq":
		ensure => present,
		provider => git,
		source => "https://github.com/zeromq/pyzmq.git",
		require => Package["Cython"],
	}

}


