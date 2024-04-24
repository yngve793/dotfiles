#!/bin/bash
#
# A small bash script to install OpenVDS on MacOS with M1 ARM CPU
# Note that the patches and fixes are possibly a bit hacky.
#

# Comment this in for detailed output what this script does. Helpful for debugging.
#set -x

# Might have to be changed to https protocol
OPENVDS_REPOSITORY_URL="https://community.opengroup.org/osdu/platform/domain-data-mgmt-services/seismic/open-vds.git"
OPENVDS_VERSION="3.4.1"

NUMBER_OF_BUILD_THREADS=6

SOURCE_DIRECTORY_PATTERN="openvds-${OPENVDS_VERSION}"
TARGET_DIR_NAME="${SOURCE_DIRECTORY_PATTERN}"

INSTALLATION_DIR="${HOME}/software/${TARGET_DIR_NAME}-install"
SOURCE_DIR="${PWD}/${SOURCE_DIRECTORY_PATTERN}-src"

if [[ ! -d ${SOURCE_DIR} ]]; then
  echo "Cloning repository"
  git clone -b ${OPENVDS_VERSION} "${OPENVDS_REPOSITORY_URL}" "${SOURCE_DIR}"
else
  git checkout -b ${OPENVDS_VERSION}
fi

pushd "${SOURCE_DIR}"

BUILD_DIR="build"
if [[ -d ${BUILD_DIR} ]]; then
  echo "Directory ${BUILD_DIR} exists. Should we delete it? [y/n]"
  read user_input
  if [[  "$user_input" == "y" ]]; then
    echo "  Deleting directory."
    rm -rf "${BUILD_DIR}"
  else
    echo "  Keeping directory."
  fi
fi

echo ${PWD}
CONFIGURATION_OPTIONS=(-S . \
    -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_JAVA=OFF \
    -DBUILD_PYTHON=ON \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_DOCS=OFF \
    -DENABLE_OPENMP=ON \
    -DDISABLE_AWS_IOMANAGER=ON \
    -DDISABLE_AZURESDKFORCPP_IOMANAGER=OFF \
    -DDISABLE_GCP_IOMANAGER=ON \
    -DDISABLE_DMS_IOMANAGER=ON \
    -DDISABLE_STRICT_WARNINGS=ON \
    -DCMAKE_FIND_FRAMEWORK=LAST \
    -DAUTO_ADJUST_UUID=OFF \
    -DBUILD_CURL=ON \
    -DCMAKE_INSTALL_PREFIX="${INSTALLATION_DIR}" \
  )

echo "Configure with following options: ${CONFIGURATION_OPTIONS[@]}"
cmake "${CONFIGURATION_OPTIONS[@]}"

BUILD_OPTIONS=(--build "${BUILD_DIR}" \
  --config Release \
  --target install \
  -j "${NUMBER_OF_BUILD_THREADS}" \
  --verbose \
  )

echo "Building with the following options ${BUILD_OPTIONS[@]}"
cmake "${BUILD_OPTIONS[@]}"

popd

echo "Creation of modulefile"
modulefilename="${OPENVDS_VERSION}.lua"
echo "Creating module file ${modulefilename}"

tee ${modulefilename} <<EOF
help([[
]])

whatis("Version: ${OPENVDS_VERSION}")
whatis("Keywords: VDS, Library")
whatis("URL: https://osdu.pages.opengroup.org/platform/domain-data-mgmt-services/seismic/open-vds/")
whatis("Description: Library to interact with VDS datasets")

local base = "${INSTALLATION_DIR}"
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
EOF
