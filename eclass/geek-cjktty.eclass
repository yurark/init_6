# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-cjktty.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (19 Aug 2013)
# @BLURB: Eclass for building kernel with cjktty patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with cjktty patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-cjktty.eclass
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
geek-cjktty_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${CJKTTY_VER:=${CJKTTY_VER:-$KMV}}
	: ${CJKTTY_SRC:=${CJKTTY_SRC:-"https://github.com/Gentoo-zh/linux-cjktty/compare/torvalds:v${CJKTTY_VER/KMV/$KMV}...${CJKTTY_VER/KMV/$KMV}-utf8.diff"}}
	: ${CJKTTY_URL:=${CJKTTY_URL:-"https://github.com/Gentoo-zh/linux-cjktty"}} # http://sourceforge.net/projects/cjktty
	: ${CJKTTY_INF:=${CJKTTY_INF:-"${YELLOW}CJK support for tty framebuffer vt -${GREEN} ${CJKTTY_URL}${NORMAL}"}}
}

geek-cjktty_init_variables

HOMEPAGE="${HOMEPAGE} ${CJKTTY_URL}"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-cjktty_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/cjktty"
	local CWD="${T}/cjktty"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}"/cjktty-"${PV}"-`date +"%Y%m%d"`.patch
	wget "${CJKTTY_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-cjktty_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/cjktty/patch_list" "${CJKTTY_INF}"
	move "${T}/cjktty" "${WORKDIR}/linux-${KV_FULL}-patches/cjktty"

	local CJKTTY_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/${PV}/cjktty"
	test -d "${CJKTTY_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${CJKTTY_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for cjktty patchset from${NORMAL} ${GREEN} ${CJKTTY_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for cjktty patchset from not existing${GREEN} ${CJKTTY_FIX_PATCH_DIR}!${NORMAL}"
	local CJKTTY_FIX_PATCH_DIR="${PATCH_STORE_DIR}/${PN}/cjktty"
	test -d "${CJKTTY_FIX_PATCH_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${CJKTTY_FIX_PATCH_DIR}" "${YELLOW}Applying user fixes for cjktty patchset from${NORMAL} ${GREEN} ${CJKTTY_FIX_PATCH_DIR}${NORMAL}" #|| einfo "${RED}Skipping apply user fixes for cjktty patchset from not existing${GREEN} ${CJKTTY_FIX_PATCH_DIR}!${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-cjktty_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${CJKTTY_INF}"
}
