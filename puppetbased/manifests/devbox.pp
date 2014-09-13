class devbox {
	class {"basicdev":}
	package {["elinks"]:
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


