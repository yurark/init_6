# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-adeos.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (02 Dec 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with adeos3 patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with adeos patch easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-adeos.eclass
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
geek-adeos_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	case "$VERSION" in
	2)
		case "$PATCHLEVEL" in
		4) # http://download.gna.org/adeos/patches/v2.4/i386/adeos-ipipe-2.4.35.5-i386-1.3-05.patch
		: ${ADEOS_VER:=${ADEOS_VER:-"2.4.35.5-i386-1.3-05"}}
		: ${ADEOS_NAME:=${ADEOS_NAME:-"adeos-ipipe-${ADEOS_VER}.patch"}}
		: ${ADEOS_SRC:=${ADEOS_SRC:-"http://download.gna.org/adeos/patches/v${KMV}/i386/${ADEOS_NAME}"}}
		;;
		6) # http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.38.8-x86-2.11-03.patch
		: ${ADEOS_VER:=${ADEOS_VER:-"2.6.38.8-x86-2.11-03"}}
		: ${ADEOS_NAME:=${ADEOS_NAME:-"adeos-ipipe-${ADEOS_VER}.patch"}}
		: ${ADEOS_SRC:=${ADEOS_SRC:-"http://download.gna.org/adeos/patches/v${KMV}/x86/${ADEOS_NAME}"}}
		;;
		esac
	;;
	3) # http://download.gna.org/adeos/patches/v3.x/x86/ipipe-core-3.8-x86-1.patch
		: ${ADEOS_VER:=${ADEOS_VER:-"3.8-x86-1"}}
		: ${ADEOS_NAME:=${ADEOS_NAME:-"ipipe-core-${ADEOS_VER}.patch"}}
		: ${ADEOS_SRC:=${ADEOS_SRC:-"http://download.gna.org/adeos/patches/v3.x/x86/${ADEOS_NAME}"}}
	;;
	esac

	: ${ADEOS_URL:=${ADEOS_URL:-"http://home.gna.org/adeos http://gna.org/projects/adeos"}}
	: ${ADEOS_INF:="${YELLOW}Interrupt pipeline patches for the Linux kernel version ${GREEN}${ADEOS_VER}${YELLOW} from ${GREEN}${ADEOS_URL}${NORMAL}"}
}

geek-adeos_init_variables

HOMEPAGE="${HOMEPAGE} ${ADEOS_URL}"

SRC_URI="${SRC_URI}
	adeos?	( ${ADEOS_SRC} )"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-adeos_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CWD="${T}/adeos"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}/${ADEOS_NAME}"
	wget "${ADEOS_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-adeos_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/adeos/patch_list" "${ADEOS_INF}"
	move "${T}/adeos" "${WORKDIR}/linux-${KV_FULL}-patches/adeos"

	ApplyPatchFix "adeos"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-adeos_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${ADEOS_INF}"
}
