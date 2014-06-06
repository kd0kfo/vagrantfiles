define pip::install ($sourcedir) {
	exec {"pip install $sourcedir":
		cwd => "$sourcedir",
		path => "/usr/bin:/usr/sbin:/bin",
	}
}
