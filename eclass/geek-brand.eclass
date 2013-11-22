# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-brand.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with gentoo branding patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with gentoo branding patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-brand.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch

EXPORT_FUNCTIONS src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-brand_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${IUSE:="${IUSE} brand"}
	: ${BRAND_URL:=${BRAND_URL:-"https://github.com/init6/init_6/wiki/geek-sources"}}
	: ${BRAND_INF:=${BRAND_INF:-"${YELLOW}Branding -${GREEN} ${BRAND_URL}${NORMAL}"}}
}

geek-brand_init_variables

HOMEPAGE="${HOMEPAGE} ${BRAND_URL}"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-brand_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${FILESDIR}/${PV}/brand/patch_list" "${BRAND_INF}"

	ApplyPatchFix "brand"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-brand_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${BRAND_INF}"
}
