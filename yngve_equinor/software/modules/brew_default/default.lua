help([["Adds most of Homebrew's paths to CGO environment variables"]])

whatis("Version: Any")
whatis("Keywords: Boost, C++, Library")
whatis("URL: ")
whatis("Description: ")

local base = "/opt/homebrew"
local include = pathJoin(base,"include")
local lib = pathJoin(base,"lib")

append_path( "CGO_CPPFLAGS", pathJoin("-I", include ), " " )
append_path( "CGO_LDFLAGS", pathJoin("-L", lib ), " " )
