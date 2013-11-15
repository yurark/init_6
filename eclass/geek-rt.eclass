# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-rt.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @BLURB: Eclass for building kernel with rt patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with rt patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-rt.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-utils geek-vars

EXPORT_FUNCTIONS src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-rt_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${RT_VER:=${RT_VER:-$KMV}}
	: ${RT_SRC:=${RT_SRC:-"mirror://kernel/linux/kernel/projects/rt/${KMV}/patch-${RT_VER/KMV/$KMV}.patch.xz"}}
	: ${RT_URL:=${RT_URL:-"http://www.kernel.org/pub/linux/kernel/projects/rt"}}
	: ${RT_INF:=${RT_INF:-"${YELLOW}Ingo Molnar"\'"s realtime preempt patches -${GREEN} ${RT_URL}${NORMAL}"}}
}

geek-rt_init_variables

HOMEPAGE="${HOMEPAGE} ${RT_URL}"

SRC_URI="${SRC_URI}
	rt?	( ${RT_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-rt_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/patch-${RT_VER}.patch.xz" "${RT_INF}"

	local RT_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/${PV}/rt"
	test -d "${RT_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${RT_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for rt patchset from${NORMAL} ${GREEN} ${RT_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for rt patchset from not existing${GREEN} ${RT_FIX_PATCH_DIR}!${NORMAL}"
	local RT_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/rt"
	test -d "${RT_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${RT_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for rt patchset from${NORMAL} ${GREEN} ${RT_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for rt patchset from not existing${GREEN} ${RT_FIX_PATCH_DIR}!${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-rt_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${RT_INF}"
}
