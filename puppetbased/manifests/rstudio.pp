node default {
	class {"rstudio":}

	file {"/etc/motd":
		content => "This is an R Studio Server made using Vagrant and Puppet\n",
	}
}

