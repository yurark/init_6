# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-bld.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with bld patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with bld patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-bld.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-bld_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${BLD_VER:=${BLD_VER:-"${KMV}"}}
	: ${BLD_SRC:=${BLD_SRC:-"https://bld.googlecode.com/files/BLD-${BLD_VER}.patch"}}
	: ${BLD_URL:=${BLD_URL:-"http://code.google.com/p/bld"}}
	: ${BLD_INF:=${BLD_INF:-"${YELLOW}Alternate CPU load distribution technique for Linux kernel scheduler version ${GREEN}${BLD_VER}${YELLOW} from ${GREEN}${BLD_URL}${NORMAL}"}}
}

geek-bld_init_variables

HOMEPAGE="${HOMEPAGE} ${BLD_URL}"

SRC_URI="${SRC_URI}
	bld?	( ${BLD_SRC} )"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-bld_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CWD="${T}/bld"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}"/bld-"${PV}"-`date +"%Y%m%d"`.patch
	wget "${BLD_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-bld_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/bld/patch_list" "${BLD_INF}"
	move "${T}/bld" "${WORKDIR}/linux-${KV_FULL}-patches/bld"

	ApplyUserPatch "bld"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-bld_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${BLD_INF}"
}
