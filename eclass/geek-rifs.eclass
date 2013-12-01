# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-rifs.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (10 Oct 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with rifs patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with rifs patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-rifs.eclass
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
geek-rifs_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${RIFS_VER:=${RIFS_VER:-"${KMV}"}}
	: ${RIFS_SRC:=${RIFS_SRC:-"https://rifs-scheduler.googlecode.com/files/rifs-kernel${RIFS_VER}"}}
	: ${RIFS_URL:=${RIFS_URL:-"https://code.google.com/p/rifs-scheduler"}}
	: ${RIFS_INF:=${RIFS_INF:-"${YELLOW}RIFS A interactivity favor scheduler version ${GREEN}${RIFS_VER}${YELLOW} from ${GREEN}${RIFS_URL}${NORMAL}"}}
}

geek-rifs_init_variables

HOMEPAGE="${HOMEPAGE} ${RIFS_URL}"

SRC_URI="${SRC_URI}
	rifs?	( ${RIFS_SRC} )"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-rifs_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CWD="${T}/rifs"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}"/rifs-"${PV}"-`date +"%Y%m%d"`.patch
	wget "${RIFS_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-rifs_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/rifs/patch_list" "${RIFS_INF}"
	move "${T}/rifs" "${WORKDIR}/linux-${KV_FULL}-patches/rifs"

	ApplyPatchFix "rifs"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-rifs_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${RIFS_INF}"
}
