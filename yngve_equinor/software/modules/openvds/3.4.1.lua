help([[
]])

whatis("Version: 3.4.1")
whatis("Keywords: VDS, Library")
whatis("URL: https://osdu.pages.opengroup.org/platform/domain-data-mgmt-services/seismic/open-vds/")
whatis("Description: Library to interact with VDS datasets")

local base = "/Users/YVI/software/openvds-3.4.1-install"
local bin = pathJoin(base,"bin")
local include = pathJoin(base,"include")
local lib = pathJoin(base,"lib")
local share = pathJoin(base,"share")

prepend_path( "PATH", bin )
prepend_path( "CPATH", include )
prepend_path( "LD_LIBRARY_PATH", lib )
prepend_path( "DYLD_LIBRARY_PATH", lib)
prepend_path( "CMAKE_MODULE_PATH", pathJoin(base,"cmake") )
prepend_path( "PYTHONPATH", pathJoin(base,"python") )
prepend_path( "OPENVDS", base)

append_path( "CGO_CPPFLAGS", pathJoin("-I", include ), " " )
--append_path( "CGO_LDFLAGS", pathJoin("-Wl,-rpath,", lib ), " " )
append_path( "CGO_LDFLAGS", pathJoin("-L", lib ), " " )
