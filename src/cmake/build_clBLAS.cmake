INCLUDE(ExternalProject)

message("CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}")
ExternalProject_Add(
    clBLAS-external
    #GIT_REPOSITORY git@github.com:clMathLibraries/clBLAS.git
    #GIT_TAG master
    #DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/clMathLibraries/clBLAS
    #GIT_SUBMODULES clBLAS
    STAMP_DIR ${CMAKE_BINARY_DIR}/clBLAS/stamp
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/clMathLibraries/clBLAS/src
    PREFIX ${CMAKE_BINARY_DIR}/clBLAS
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #CONFIGURE_COMMAND ${CMAKE_COMMAND} -Wno-dev "-G${CMAKE_GENERATOR}" <SOURCE_DIR>
    #-DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
    #"-DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS} -w -fPIC"
    #-DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
    #"-DCMAKE_C_FLAGS:STRING=${CMAKE_C_FLAGS} -w -fPIC"
    #-DCMAKE_BUILD_TYPE:STRING=Release
    CMAKE_CACHE_ARGS 
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
    -DOPENCL_INCLUDE_DIRS:STRING=${CMAKE_CURRENT_SOURCE_DIR}/src/EasyCL/thirdparty/clew/include;${CMAKE_CURRENT_SOURCE_DIR}/src/EasyCL/thirdparty/clew/include/proxy-opencl
    -DOPENCL_LIBRARIES:STRING=${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}clew${CMAKE_SHARED_LIBRARY_SUFFIX}
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_CLIENT:BOOL=OFF
    -DBUILD_TEST:BOOL=OFF
    -DBUILD_KTEST:BOOL=OFF
    -DSUFFIX_LIB:STRING=
    -DCORR_TEST_WITH_ACML:BOOL=OFF
    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo
    )

#ExternalProject_Get_Property(clBLAS-external install_dir)
ADD_LIBRARY(clBLAS SHARED IMPORTED)
#SET_TARGET_PROPERTIES(clBLAS PROPERTIES IMPORTED_LOCATION ${clBLAS_location})
ADD_DEPENDENCIES(clBLAS clBLAS-external)
#SET(CLBLAS_INCLUDE_DIRS ${CMAKE_INSTALL_PREFIX}/include)
SET(clBLAS_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src/clMathLibraries/clBLAS/src ${CMAKE_CURRENT_SOURCE_DIR}/src/EasyCL/thirdparty/clew/include/proxy-opencl)
#SET(CLBLAS_LIBRARIES ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}clBLAS${CMAKE_SHARED_LIBRARY_SUFFIX})
#SET(CLBLAS_FOUND ON)

set_target_properties(clBLAS PROPERTIES
#  INSTALL_RPATH ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}EasyCL${CMAKE_SHARED_LIBRARY_SUFFIX}
  IMPORTED_LOCATION ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}clBLAS${CMAKE_SHARED_LIBRARY_SUFFIX}
)

add_custom_target(clblas_delete_stamp clBLAS-external 
  ${CMAKE_COMMAND} -E  remove_directory "${CMAKE_BINARY_DIR}/clBLAS/stamp"
)

