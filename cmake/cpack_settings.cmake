# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the Apache 2.0 License.

set(CPACK_PACKAGE_NAME "${CCF_PROJECT}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Confidential Consortium Framework")
set(CPACK_PACKAGE_CONTACT "https://github.com/Microsoft/CCF")
set(CPACK_RESOURCE_FILE_LICENSE "${CCF_DIR}/LICENSE")
set(CPACK_PACKAGE_VERSION ${CCF_RELEASE_VERSION})
set(CPACK_PACKAGING_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

set(CPACK_DEBIAN_PACKAGE_VERSION "${CCF_RELEASE_VERSION}")

if(CCF_VERSION_SUFFIX)
  set(CPACK_DEBIAN_PACKAGE_VERSION
      "${CPACK_DEBIAN_PACKAGE_VERSION}~${CCF_VERSION_SUFFIX}"
  )
endif()

message(STATUS "Debian package version: ${CPACK_DEBIAN_PACKAGE_VERSION}")

# Note: On Ubuntu, the most up-to-date version of the OpenSSL deb package is
# 1.1.1f, which corresponds to the OpenSSL 1.1.1t release (latest security
# patches).
set(CCF_DEB_BASE_DEPENDENCIES
    "libuv1 (>= 1.34.2);openssl (>=1.1.1f);libnghttp2-14 (>=1.40.0);curl (>=7.68.0)"
)
set(CCF_DEB_DEPENDENCIES ${CCF_DEB_BASE_DEPENDENCIES})

if(USE_LIBCXX)
  list(APPEND CCF_DEB_DEPENDENCIES "libc++1-15;libc++abi1-15")
endif()

list(JOIN CCF_DEB_DEPENDENCIES ", " CPACK_DEBIAN_PACKAGE_DEPENDS)

set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)

include(CPack)
