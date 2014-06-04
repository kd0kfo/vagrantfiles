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

node "ipython", /ipython\..+/ {
	class {"ipython":}
	
	file {"/etc/motd":
		content => "This is an ipython notebook server made using Vagrant and Puppet\n"
	}

}


