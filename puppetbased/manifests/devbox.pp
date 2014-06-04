class devbox {
	class {"basicdev":}
	package {["python", "python-devel", "vim-enhanced", "emacs", "elinks"]:
		require => Class["basicdev"]
	}

	class {"pip":}
}

node default {
	class {"devbox":}

	file {"/etc/motd":
		content => "This is a development machine made using Vagrant and Puppet\n",
	}
}


