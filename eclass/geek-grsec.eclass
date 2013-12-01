# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-grsec.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with grsec patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with grsec patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-grsec.eclass
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
geek-grsec_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${GRSEC_VER:=${GRSEC_VER:-"${KSV}"}}
	: ${GRSEC_SRC:=${GRSEC_SRC:-"git://git.overlays.gentoo.org/proj/hardened-patchset.git"}}
	: ${GRSEC_URL:=${GRSEC_URL:-"http://hardened.gentoo.org"}}
	: ${GRSEC_INF:=${GRSEC_INF:-"${YELLOW}GrSecurity patches version ${GREEN}${GRSEC_VER}${YELLOW} from ${GREEN}${GRSEC_URL}${NORMAL}"}}
}

geek-grsec_init_variables

HOMEPAGE="${HOMEPAGE} ${GRSEC_URL}"

DEPEND="${DEPEND}
	grsec?	( dev-vcs/git
		>=sys-apps/gradm-2.2.2 )"

RDEPEND=">=sys-devel/gcc-4.5"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-grsec_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/grsec"
	local CWD="${T}/grsec"
	local CTD="${T}/grsec"$$
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	if [ -d ${CSD} ]; then
	cd "${CSD}" || die "${RED}cd ${CSD} failed${NORMAL}"
		if [ -e ".git" ]; then # git
			git fetch --all && git pull --all
		fi
	else
		git clone "${GRSEC_SRC}" "${CSD}" > /dev/null 2>&1; cd "${CSD}" || die "${RED}cd ${CSD} failed${NORMAL}"; git_get_all_branches
	fi

	copy "${CSD}" "${CTD}"

	cd "${CTD}"/"${GRSEC_VER}" || die "${RED}cd ${CTD}/${GRSEC_VER} failed${NORMAL}"

	ls -1 | grep "linux" | xargs -I{} rm -rf "{}"
	ls -1 | xargs -I{} cp "{}" "${CWD}"

	rm -rf "${CTD}" || die "${RED}rm -rf ${CTD} failed${NORMAL}"

	ls -1 "${CWD}" | grep ".patch" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-grsec_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/grsec/patch_list" "${GRSEC_INF}"
	move "${T}/grsec" "${WORKDIR}/linux-${KV_FULL}-patches/grsec"

	ApplyPatchFix "grsec"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-grsec_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	local GRADM_COMPAT="sys-apps/gradm-2.9.1"
	einfo "${BLUE}Hardened Gentoo provides three different predefined grsecurity level:${NORMAL}${BR}
${BLUE}[server], [workstation], and [virtualization].  Those who intend to${NORMAL}${BR}
${BLUE}use one of these predefined grsecurity levels should read the help${NORMAL}${BR}
${BLUE}associated with the level.  Because some options require >=gcc-4.5,${NORMAL}${BR}
${BLUE}users with more, than one version of gcc installed should use gcc-config${NORMAL}${BR}
${BLUE}to select a compatible version.${NORMAL}${BR}
${BR}
${BLUE}Users of grsecurity's RBAC system must ensure they are using${NORMAL}${BR}
${RED}${GRADM_COMPAT}${NORMAL}${BLUE}, which is compatible with${NORMAL} ${RED}${PF}${NORMAL}${BLUE}.${NORMAL}${BR}
${BLUE}It is strongly recommended that the following command is issued${NORMAL}${BR}
${BLUE}prior to booting a${NORMAL} ${RED}${PF}${NORMAL} ${BLUE}kernel for the first time:${NORMAL}${BR}
${BR}
${RED}emerge -na =${GRADM_COMPAT}*${NORMAL}${BR}"
}
