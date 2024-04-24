help([["Adds vds-slice environment varables"]])

whatis("Version: Any")
whatis("Keywords: Boost, C++, Library")
whatis("URL: ")
whatis("Description: ")

local base = "~/equinor/github/vds-slice"
local core = pathJoin(base,"internal/core")
prepend_path( "CPATH", core )

