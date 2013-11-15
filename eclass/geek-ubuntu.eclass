# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-ubuntu.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (10 Oct 2013)
# @BLURB: Eclass for building kernel with ubuntu patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with ubuntu patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-ubuntu.eclass
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
geek-ubuntu_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${UBUNTU_VER:=${UBUNTU_VER:-3.2.0-55.85}}
	: ${UBUNTU_SRC:=${UBUNTU_SRC:-"http://archive.ubuntu.com/ubuntu/pool/main/l/linux/linux_${UBUNTU_VER}.diff.gz"}}
	: ${UBUNTU_URL:=${UBUNTU_URL:-"http://www.ubuntu.com"}}
	: ${UBUNTU_INF:="${YELLOW}Ubuntu patches -${GREEN} ${UBUNTU_URL}${NORMAL}"}
}

geek-ubuntu_init_variables

HOMEPAGE="${HOMEPAGE} ${UBUNTU_URL}"

SRC_URI="${SRC_URI}
	ubuntu?	( ${UBUNTU_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-ubuntu_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/linux_${UBUNTU_VER}.diff.gz" "${UBUNTU_INF}"

	local UBUNTU_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/${PV}/ubuntu"
	test -d "${UBUNTU_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${UBUNTU_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for ubuntu patchset from${NORMAL} ${GREEN} ${UBUNTU_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for ubuntu patchset from not existing${GREEN} ${UBUNTU_FIX_PATCH_DIR}!${NORMAL}"
	local UBUNTU_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/ubuntu"
	test -d "${UBUNTU_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${UBUNTU_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for ubuntu patchset from${NORMAL} ${GREEN} ${UBUNTU_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for ubuntu patchset from not existing${GREEN} ${UBUNTU_FIX_PATCH_DIR}!${NORMAL}"

	# Comment out EXTRAVERSION added by ubuntu patch:
#	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile || die
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "Makefile"

	sed	-i -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' Makefile || die
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-ubuntu_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${UBUNTU_INF}"
}
