class pip::install ($sourcedir) {
	exec {"pip install $sourcedir":
		cwd => "$sourcedir",
	}
}
