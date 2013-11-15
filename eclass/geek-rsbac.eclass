# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-rsbac.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (10 Oct 2013)
# @BLURB: Eclass for building kernel with rsbac patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with rsbac patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-rsbac.eclass
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
geek-rsbac_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${RSBAC_VER:=${RSBAC_VER:-$KMV}}
	: ${RSBAC_NAME:=${RSBAC_NAME:-patch-linux-${PV}-rsbac-${RSBAC_VER/KMV/$KMV}.diff.xz}}
	: ${RSBAC_SRC:=${RSBAC_SRC:-"http://download.rsbac.org/patches/${RSBAC_VER/KMV/$KMV}/${RSBAC_NAME}"}}
	: ${RSBAC_URL:=${RSBAC_URL:-"http://www.rsbac.org"}}
	: ${RSBAC_INF=${RSBAC_INF:-"${YELLOW}RSBAC (Rule Set Based Access Control) patches -${GREEN} ${RSBAC_URL}${NORMAL}"}}
}

geek-rsbac_init_variables

HOMEPAGE="${HOMEPAGE} ${RSBAC_URL}"

SRC_URI="${SRC_URI}
	rsbac?	( ${RSBAC_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-rsbac_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/${RSBAC_NAME}" "${RSBAC_INF}"

	local RSBAC_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/${PV}/rsbac"
	test -d "${RSBAC_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${RSBAC_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for rsbac patchset from${NORMAL} ${GREEN} ${RSBAC_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for rsbac patchset from not existing${GREEN} ${RSBAC_FIX_PATCH_DIR}!${NORMAL}"
	local RSBAC_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/rsbac"
	test -d "${RSBAC_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${RSBAC_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for rsbac patchset from${NORMAL} ${GREEN} ${RSBAC_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for rsbac patchset from not existing${GREEN} ${RSBAC_FIX_PATCH_DIR}!${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-rsbac_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${RSBAC_INF}"
}
