class ipython {
	
	class {"basicdev":}
	package {["python-matplotlib", "python-gtkextra",  "elinks"]:
		require => Class["basicdev"],
	} -> 
	package {"numpy >= 1.8.1":
		provider => "pip",
	} ->
	package {"scipy":
		provider => "pip",
	} ->
	package {["pandas", "openpyxl<2.0.0"]:
		provider => "pip",
	}

	
	package {["blas-devel", "lapack-devel"]:}

	class {"pip":}

	class {"ipython::base":}
}


