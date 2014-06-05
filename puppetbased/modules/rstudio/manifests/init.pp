class rstudio {
	class {"epel":}
	package {["blas-devel", "lapack-devel"]:} ->
	class {"rstudio::base": }
}
