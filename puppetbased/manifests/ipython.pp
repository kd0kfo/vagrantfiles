node default {
	class {"ipython":}
	
	file {"/etc/motd":
		content => "This is an ipython notebook server made using Vagrant and Puppet\n"
	}

}


