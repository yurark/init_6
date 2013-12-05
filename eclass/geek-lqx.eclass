# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-lqx.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with lqx patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with lqx patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-lqx.eclass
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
geek-lqx_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${LQX_VER:=${LQX_VER:-"${KMV}"}}
	: ${LQX_SRC:=${LQX_SRC:-"http://liquorix.net/sources/${LQX_VER/KMV/$KMV}.patch.gz"}}
	: ${LQX_URL:=${LQX_URL:-"http://liquorix.net"}}
	: ${LQX_INF:=${LQX_INF:-"${YELLOW}Liquorix patches version ${GREEN}${LQX_VER}${YELLOW} from ${GREEN}${LQX_URL}${NORMAL}"}}
}

geek-lqx_init_variables

HOMEPAGE="${HOMEPAGE} ${LQX_URL}"

SRC_URI="${SRC_URI}
	lqx?	( ${LQX_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-lqx_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/${LQX_VER/KMV/$KMV}.patch.gz" "${LQX_INF}"

	ApplyUserPatch "lqx"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-lqx_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${LQX_INF}"
}
