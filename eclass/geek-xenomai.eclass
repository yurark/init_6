# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-xenomai.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (17 Oct 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with xenomai patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with xenomai patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-xenomai.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

# https://bugs.gentoo.org/show_bug.cgi?id=438236

inherit geek-patch geek-utils geek-vars

EXPORT_FUNCTIONS src_unpack src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-xenomai_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${XENOMAI_VER:=${XENOMAI_VER:-"2.6.3"}}
	: ${XENOMAI_NAME:=${XENOMAI_NAME:-xenomai-${XENOMAI_VER}.tar.bz2}}
	: ${XENOMAI_SRC:=${XENOMAI_SRC:-"http://download.gna.org/xenomai/stable/${XENOMAI_NAME}"}}
	: ${XENOMAI_URL:=${XENOMAI_URL:-"http://www.xenomai.org"}}
	: ${XENOMAI_INF:="${YELLOW}Real-Time Framework for Linux version ${GREEN}${XENOMAI_VER}${YELLOW} from ${GREEN}${XENOMAI_URL}${NORMAL}"}
}

geek-xenomai_init_variables

HOMEPAGE="${HOMEPAGE} ${XENOMAI_URL}"

SRC_URI="${SRC_URI}
	xenomai?	( ${XENOMAI_SRC} )"

RDEPEND="sys-apps/ed"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-xenomai_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CWD="${T}/xenomai"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"

	unpack ${XENOMAI_NAME} || die "unpack failed"
	cd ${CWD}/xenomai-${XENOMAI_VER}
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-xenomai_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${XENOMAI_INF}"
	"${T}/xenomai/xenomai-${XENOMAI_VER}/"scripts/prepare-kernel.sh --linux=${S} --arch=x86 --default || die "prepare kernel failed"

#	rm -rf "${T}/xenomai" || die "${RED}rm -rf ${T}/xenomai failed${NORMAL}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-xenomai_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${XENOMAI_INF} ${ADEOS_INF}"
}
