# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-gentoo.eclass
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @BLURB: Eclass for building kernel with gentoo patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with gentoo patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-gentoo.eclass
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
geek-gentoo_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${GENTOO_VER:=${GENTOO_VER:-$KMV}}
	: ${GENTOO_SRC:=${GENTOO_SRC:-"svn://anonsvn.gentoo.org/linux-patches/genpatches-2.6/trunk"}}
	: ${GENTOO_URL:=${GENTOO_URL:-"http://dev.gentoo.org/~mpagano/genpatches"}}
	: ${GENTOO_INF:=${GENTOO_INF:-"${YELLOW}Gentoo patches -${GREEN} ${GENTOO_URL}${NORMAL}"}}
}

geek-gentoo_init_variables

HOMEPAGE="${HOMEPAGE} ${GENTOO_URL}"

DEPEND="${DEPEND}
	gentoo?	( dev-vcs/subversion )"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-gentoo_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/gentoo"
	local CWD="${T}/gentoo"
	local CTD="${T}/gentoo"$$
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	if [ -d ${CSD} ]; then
		cd "${CSD}" || die "${RED}cd ${CSD} failed${NORMAL}"
		if [ -e ".svn" ]; then # git
			svn up
		fi
	else
		svn co "${GENTOO_SRC}" "${CSD}" > /dev/null 2>&1
	fi

	copy "${CSD}" "${CTD}"
	cd "${CTD}"/${KMV} || die "${RED}cd ${CTD}/${KMV} failed${NORMAL}"

	find -name .svn -type d -exec rm -rf {} \ > /dev/null 2>&1
	find -type d -empty -delete

	ls -1 | grep "linux" | xargs -I{} rm -rf "{}"
	ls -1 | grep ".patch" > "$CWD"/patch_list

	copy "${CTD}/${KMV}" "${CWD}"

	rm -rf "${CTD}" || die "${RED}rm -rf ${CTD} failed${NORMAL}"
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-gentoo_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/gentoo/patch_list" "${GENTOO_INF}"
	move "${T}/gentoo" "${WORKDIR}/linux-${KV_FULL}-patches/gentoo"

	ApplyPatchFix "gentoo"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-gentoo_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${GENTOO_INF}"
}
