# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-fix.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @BLURB: Eclass for building kernel with fix patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with fix patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-fix.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-vars

EXPORT_FUNCTIONS src_prepare

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-fix_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	local disable_fixes_cfg=$(source $cfg_file 2>/dev/null; echo ${disable_fixes})
	: ${disable_fixes:=${disable_fixes_cfg:-no}} # disable_fixes=yes/no
}

geek-fix_init_variables

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-fix_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	if [ "${disable_fixes}" = "no" ]; then
		ApplyPatch "${FILESDIR}/${PV}/fix/patch_list" "${YELLOW}Fixes for current kernel${NORMAL}"
	fi
}
