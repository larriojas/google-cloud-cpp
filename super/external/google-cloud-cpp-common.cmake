# ~~~
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ~~~

include(ExternalProject)
include(ExternalProjectHelper)
include(external/grpc)
include(external/googleapis)
include(external/googletest)

if (NOT TARGET google-cloud-cpp-common-project)
    # Give application developers a hook to configure the version and hash
    # downloaded from GitHub.
    set(GOOGLE_CLOUD_CPP_URL
        "https://github.com/googleapis/google-cloud-cpp-common/archive/v0.15.0.tar.gz"
    )
    set(GOOGLE_CLOUD_CPP_SHA256
        "cbed2daeda4f8c9fc22f8aed8ed258c2082b69d69826b67e97529e0f7c5655f9")

    set_external_project_prefix_vars()

    set_external_project_build_parallel_level(PARALLEL)

    ExternalProject_Add(
        google-cloud-cpp-common-project
        DEPENDS googleapis_project googletest_project grpc_project
        EXCLUDE_FROM_ALL ON
        PREFIX "${CMAKE_BINARY_DIR}/external/google-cloud-cpp-common"
        INSTALL_DIR "${GOOGLE_CLOUD_CPP_EXTERNAL_PREFIX}"
        URL ${GOOGLE_CLOUD_CPP_URL}
        URL_HASH SHA256=${GOOGLE_CLOUD_CPP_SHA256}
                 LIST_SEPARATOR
                 |
        CMAKE_ARGS -DBUILD_TESTING=OFF
                   -DGOOGLE_CLOUD_CPP_TESTING_UTIL_ENABLE_INSTALL=ON
                   -DCMAKE_PREFIX_PATH=${GOOGLE_CLOUD_CPP_PREFIX_PATH}
                   -DCMAKE_INSTALL_RPATH=${GOOGLE_CLOUD_CPP_INSTALL_RPATH}
                   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> ${PARALLEL}
        LOG_DOWNLOAD ON
        LOG_CONFIGURE OFF
        LOG_BUILD OFF
        LOG_INSTALL OFF)
endif ()
