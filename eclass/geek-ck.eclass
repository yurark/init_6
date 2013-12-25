# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: ck.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with ck patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with ck patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-ck.eclass
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
geek-ck_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${CK_VER:=${CK_VER:-"${KMV}-ck1"}} # Patchset version
	: ${CK_SRC:=${CK_SRC:-"http://ck.kolivas.org/patches/3.0/${KMV}/${CK_VER}/patch-${CK_VER}.lrz"}} # Patchset sources url
	: ${CK_URL:=${CK_URL:-"http://users.on.net/~ckolivas/kernel"}} # Patchset url
	: ${CK_INF:=${CK_INF:-"${YELLOW}Con Kolivas high performance patchset version ${GREEN}${CK_VER}${YELLOW} from ${GREEN}${CK_URL}${NORMAL}"}}
}

geek-ck_init_variables

HOMEPAGE="${HOMEPAGE} ${CK_URL}"

SRC_URI="${SRC_URI}
	ck?	( ${CK_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-ck_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/patch-${CK_VER}.lrz" "${CK_INF}"

	ApplyUserPatch "ck"

	# Comment out EXTRAVERSION added by CK patch:
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "Makefile"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-ck_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${CK_INF}"
}
