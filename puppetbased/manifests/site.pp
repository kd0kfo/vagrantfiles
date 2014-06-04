node default {
	package {["vim-enhanced", "emacs", "elinks"]:}

	file {"/etc/motd":
		content => "Build using Vagrant and Puppet\n",
	}

}


