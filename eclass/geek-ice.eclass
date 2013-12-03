# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-ice.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with ice patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with ice patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-ice.eclass
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
geek-ice_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${ICE_VER:=${ICE_VER:-"${KSV}"}}
	: ${ICE_SRC:=${ICE_SRC:-"https://github.com/NigelCunningham/tuxonice-kernel/compare/vanilla-${ICE_VER/KMV/$KMV}...tuxonice-${ICE_VER/KMV/$KMV}.diff"}}
	: ${ICE_URL:=${ICE_URL:-"http://tuxonice.net"}}
	: ${ICE_INF:=${ICE_INF:-"${YELLOW}TuxOnIce version ${GREEN}${ICE_VER}${YELLOW} from ${GREEN}${ICE_URL}${NORMAL}"}}
}

geek-ice_init_variables

HOMEPAGE="${HOMEPAGE} ${ICE_URL}"

DEPEND="${DEPEND}
	ice?	( >=sys-apps/tuxonice-userui-1.0
		|| ( >=sys-power/hibernate-script-2.0 sys-power/pm-utils ) )"

# @FUNCTION: src_unpack
# @USAGE:
# @DESCRIPTION: Extract source packages and do any necessary patching or fixes.
geek-ice_src_unpack() {
	debug-print-function ${FUNCNAME} "$@"

	local CSD="${GEEK_STORE_DIR}/ice"
	local CWD="${T}/ice"
	shift
	test -d "${CWD}" >/dev/null 2>&1 && cd "${CWD}" || mkdir -p "${CWD}"; cd "${CWD}"
	dest="${CWD}"/tuxonice-kernel-"${PV}"-`date +"%Y%m%d"`.patch
	wget "${ICE_SRC}" -O "${dest}" > /dev/null 2>&1
	cd "${CWD}" || die "${RED}cd ${CWD} failed${NORMAL}"
	ls -1 | grep ".patch" | xargs -I{} xz "{}" | xargs -I{} cp "{}" "${CWD}"
	ls -1 "${CWD}" | grep ".patch.xz" > "${CWD}"/patch_list
}

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-ice_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${T}/ice/patch_list" "${ICE_INF}"
	move "${T}/ice" "${WORKDIR}/linux-${KV_FULL}-patches/ice"

	ApplyPatchFix "ice"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-ice_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	ewarn "${RED}${P}${NORMAL} ${BLUE}has the following optional runtime dependencies:${NORMAL}${BR}
  ${RED}sys-apps/tuxonice-userui${NORMAL}${BR}
    ${BLUE}provides minimal userspace progress information related to${NORMAL}${BR}
    ${BLUE}suspending and resuming process${NORMAL}${BR}
  ${RED}sys-power/hibernate-script${NORMAL} ${BLUE}or${NORMAL} ${RED}sys-power/pm-utils${NORMAL}${BR}
    ${BLUE}runtime utilites for hibernating and suspending your computer${NORMAL}${BR}
${BR}
${BLUE}If there are issues with this kernel, please direct any${NORMAL}${BR}
${BLUE}queries to the tuxonice-users mailing list:${NORMAL}${BR}
${RED}http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/${NORMAL}${BR}"
}
