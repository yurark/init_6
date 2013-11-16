# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-optimization.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (19 Aug 2013)
# @BLURB: Eclass for building kernel with optimization patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with optimization patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-optimization.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-utils geek-vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-optimization_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${OPTIMIZATION_VER:=${OPTIMIZATION_VER:-$KMV}}
	: ${OPTIMIZATION_SRC:=${OPTIMIZATION_SRC:-"https://raw.github.com/graysky2/kernel_gcc_patch/master/kernel-${KMV/./}-gcc48-${OPTIMIZATION_VER}.patch"}}
	: ${OPTIMIZATION_URL:=${OPTIMIZATION_URL:-"https://github.com/graysky2/kernel_gcc_patch"}}
	: ${OPTIMIZATION_INF:=${OPTIMIZATION_INF:-"${YELLOW}Kernel patch enables gcc optimizations for additional CPUs -${GREEN} ${OPTIMIZATION_URL}${NORMAL}"}}
}

geek-optimization_init_variables

HOMEPAGE="${HOMEPAGE} ${OPTIMIZATION_URL}"

SRC_URI="${SRC_URI}
	optimization?	( ${OPTIMIZATION_SRC} )"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-optimization_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/optimization"
	local CWD="${T}/optimization"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}"/kernel-${KMV/./}-gcc48-${OPTIMIZATION_VER}.patch
	wget "${OPTIMIZATION_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-optimization_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/optimization/patch_list" "${OPTIMIZATION_INF}"
	move "${T}/optimization" "${WORKDIR}/linux-${KV_FULL}-patches/optimization"

	local OPTIMIZATION_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/${PV}/optimization"
	test -d "${OPTIMIZATION_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${OPTIMIZATION_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for optimization patchset from${NORMAL} ${GREEN} ${OPTIMIZATION_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for optimization patchset from not existing${GREEN} ${OPTIMIZATION_FIX_PATCH_DIR}!${NORMAL}"
	local OPTIMIZATION_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/optimization"
	test -d "${OPTIMIZATION_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${OPTIMIZATION_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for optimization patchset from${NORMAL} ${GREEN} ${OPTIMIZATION_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for optimization patchset from not existing${GREEN} ${OPTIMIZATION_FIX_PATCH_DIR}!${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-optimization_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${OPTIMIZATION_INF}"
}
