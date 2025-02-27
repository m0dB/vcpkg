function(qt_get_submodule_name OUT_NAME)
    string(REPLACE "5-" "" _tmp_name ${PORT})
    set(${OUT_NAME} ${_tmp_name} PARENT_SCOPE)
endfunction()

function(qt_download_submodule)
    cmake_parse_arguments(_csc "" "OUT_SOURCE_PATH" "PATCHES" ${ARGN})
    
    if(NOT DEFINED _csc_OUT_SOURCE_PATH)
        message(FATAL_ERROR "qt_download_module requires parameter OUT_SOURCE_PATH to be set! Please correct the portfile!")
    endif()
    
    vcpkg_buildpath_length_warning(37)
    qt_get_submodule_name(NAME)

    set(FULL_VERSION "${QT_MAJOR_MINOR_VER}.${QT_PATCH_VER}")
    set(ARCHIVE_NAME "${NAME}-everywhere-src-${FULL_VERSION}.tar.xz")

    vcpkg_download_distfile(ARCHIVE_FILE
        URLS "https://download.qt.io/archive/qt/${QT_MAJOR_MINOR_VER}/${FULL_VERSION}/submodules/${ARCHIVE_NAME}"
        FILENAME ${ARCHIVE_NAME}
        SHA512 ${QT_HASH_${PORT}}
    )
    vcpkg_extract_source_archive_ex(
        OUT_SOURCE_PATH SOURCE_PATH
        ARCHIVE "${ARCHIVE_FILE}"
        REF ${FULL_VERSION}
        PATCHES ${_csc_PATCHES}
    )

    set(${_csc_OUT_SOURCE_PATH} ${SOURCE_PATH} PARENT_SCOPE)
endfunction()
