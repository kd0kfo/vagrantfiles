node default {
	class{"webbox":}

	file {"/etc/motd":
		content => "This machine was setup using vagrant and puppet to be a web server.\n",
		ensure => present,
	}

}
