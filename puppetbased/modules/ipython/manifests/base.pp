class ipython::base {
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
		ensure => present,
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

       pip::install {"ipython":
               sourcedir => "/usr/src/ipython",
               require => [Pip::Install["pyzmq"], Vcsrepo["/usr/src/ipython"]],
       }

       pip::install {"pyzmq":
               sourcedir => "/usr/src/pyzmq",
               require => Vcsrepo["/usr/src/pyzmq"],
       }

}
