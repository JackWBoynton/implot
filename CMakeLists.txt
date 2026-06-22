cmake_minimum_required(VERSION 3.8)
project(implot CXX)

find_package(imgui CONFIG REQUIRED)

include(GNUInstallDirs)

add_library(${PROJECT_NAME} "")
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
target_include_directories(
	${PROJECT_NAME}
	PUBLIC
	   	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
      $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(${PROJECT_NAME} PRIVATE imgui::imgui)

target_sources(
	${PROJECT_NAME}
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/implot.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/implot_items.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/implot_demo.cpp
)

install(
	TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}_target
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(NOT IMPLOT_SKIP_HEADERS)
    install(FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/implot.h
		${CMAKE_CURRENT_SOURCE_DIR}/implot_internal.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )
endif()

install(
	EXPORT ${PROJECT_NAME}_target
	NAMESPACE ${PROJECT_NAME}::
	FILE ${PROJECT_NAME}-config.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
