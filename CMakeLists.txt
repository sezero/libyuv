# CMakeLists for libyuv

PROJECT ( YUV C )
CMAKE_MINIMUM_REQUIRED( VERSION 3.2 )

include(CMakePushCheckState)
include(CheckCSourceCompiles)
include(CheckLibraryExists)

SET ( ly_base_dir	${PROJECT_SOURCE_DIR} )
SET ( ly_src_dir	${ly_base_dir}/source )
SET ( ly_inc_dir	${ly_base_dir}/include )
SET ( ly_lib_name	yuv )
SET ( ly_lib_static	${ly_lib_name} )
SET ( ly_lib_shared	${ly_lib_name}_shared )

FILE ( GLOB_RECURSE	ly_source_files ${ly_src_dir}/*.c )
LIST ( SORT			ly_source_files )

INCLUDE_DIRECTORIES( BEFORE ${ly_inc_dir} )

set (CMAKE_C_STANDARD 99)
if(MSVC)
  ADD_DEFINITIONS ( -D_CRT_SECURE_NO_WARNINGS )
endif()
if(NOT MSVC AND (CMAKE_COMPILER_IS_GNUCC OR CMAKE_C_COMPILER_ID MATCHES "Clang"))
  add_compile_options(-Wall)
endif()

if(NOT WIN32 AND (CMAKE_COMPILER_IS_GNUCC OR CMAKE_C_COMPILER_ID MATCHES "Clang"))
  cmake_push_check_state()
  set(CMAKE_REQUIRED_FLAGS "-fvisibility=hidden -Werror")
  check_c_source_compiles("
     #if !defined(__GNUC__)||(__GNUC__ < 4)
     #error not gcc4 or newer.
     #endif
     int main(void) { return 0; }" HAVE_GCC_FVISIBILITY)
  if(HAVE_GCC_FVISIBILITY)
     add_compile_options("-fvisibility=hidden")
  endif()
  cmake_pop_check_state()
endif()

if(NOT APPLE AND NOT MSVC AND NOT CMAKE_SYSTEM_NAME MATCHES "kOpenBSD.*|OpenBSD.*")
  cmake_push_check_state()
  list(APPEND CMAKE_REQUIRED_LINK_OPTIONS "-Wl,--no-undefined")
  check_c_source_compiles("int main(void) { return 0; }"
         LINKER_SUPPORTS_WL_NO_UNDEFINED)
  cmake_pop_check_state()
endif()

check_library_exists(m log10 "" HAVE_LIBM)

# this creates the static library (.a)
ADD_LIBRARY				( ${ly_lib_static} STATIC ${ly_source_files} )

# this creates the shared library (.so)
ADD_LIBRARY				( ${ly_lib_shared} SHARED ${ly_source_files} )
SET_TARGET_PROPERTIES	( ${ly_lib_shared} PROPERTIES OUTPUT_NAME "${ly_lib_name}" )
SET_TARGET_PROPERTIES	( ${ly_lib_shared} PROPERTIES PREFIX "lib" )
if(WIN32)
  SET_TARGET_PROPERTIES	( ${ly_lib_shared} PROPERTIES IMPORT_PREFIX "lib" )
endif()
target_compile_definitions(${ly_lib_shared} PRIVATE LIBYUV_BUILDING_SHARED_LIBRARY)
if(HAVE_LIBM)
  target_link_libraries(${ly_lib_shared} PRIVATE -lm)
endif()
if(APPLE)
  target_link_libraries(${ly_lib_shared} PRIVATE -Wl,-undefined,error)
elseif(LINKER_SUPPORTS_WL_NO_UNDEFINED)
  target_link_libraries(${ly_lib_shared} PRIVATE -Wl,--no-undefined)
endif()

# install the conversion tool, .so, .a, and all the header files
INSTALL ( TARGETS ${ly_lib_static}						DESTINATION lib )
INSTALL ( TARGETS ${ly_lib_shared} LIBRARY				DESTINATION lib RUNTIME DESTINATION bin )
INSTALL ( DIRECTORY ${PROJECT_SOURCE_DIR}/include/		DESTINATION include )
