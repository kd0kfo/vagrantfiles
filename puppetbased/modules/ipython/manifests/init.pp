class ipython {
	
	class {"basicdev":}
	package {["python-matplotlib", "python-gtkextra",  "elinks"]:
		require => Class["basicdev"],
	}
	
	package {["blas-devel", "lapack-devel"]:}

	class {"pip":}

	class {"ipython::base":}
}


