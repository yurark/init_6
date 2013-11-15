# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-upatch.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @BLURB: Eclass for building kernel with user patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with user patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-upatch.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-vars

EXPORT_FUNCTIONS src_prepare

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-upatch_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	# from geek-vars.eclass defauld PATCH_USER_DIR="${PATCH_STORE_DIR}/${PN}/${PV}"
	test -d "${PATCH_USER_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${PATCH_USER_DIR}" "${YELLOW}Applying user patches from${GREEN} ${PATCH_USER_DIR}${NORMAL}" || einfo "${RED}Skipping apply user patches from not existing${GREEN} ${PATCH_USER_DIR}${RED}!${NORMAL}"
	local ALT_PATCH_USER_DIR="${PATCH_STORE_DIR}/${PN}";
	test -d "${ALT_PATCH_USER_DIR}" >/dev/null 2>&1 && ApplyUserPatch "${ALT_PATCH_USER_DIR}" "${YELLOW}Applying user patches from${GREEN} ${ALT_PATCH_USER_DIR}${NORMAL}" || einfo "${RED}Skipping apply user patches from not existing${GREEN} ${ALT_PATCH_USER_DIR}${RED}!${NORMAL}"
}
