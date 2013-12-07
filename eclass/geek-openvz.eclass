# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-openvz.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (07 Dec 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for building kernel with openvz patchset.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel with openvz patches easily.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-openvz.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

inherit geek-patch geek-vars

EXPORT_FUNCTIONS src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
geek-openvz_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${OPENVZ_VER:=${OPENVZ_VER:-"${KMV}"}}
	: ${OPENVZ_SRC:=${OPENVZ_SRC:-"http://download.openvz.org/kernel/branches/rhel6-${KSV}/${OPENVZ_VER}/patches/patch-${OPENVZ_VER}-combined.gz
	http://download.openvz.org/kernel/branches/rhel6-${KSV}/${OPENVZ_VER}/configs/config-${KSV}-${OPENVZ_VER}.i686
	http://download.openvz.org/kernel/branches/rhel6-${KSV}/${OPENVZ_VER}/configs/config-${KSV}-${OPENVZ_VER}.x86_64"}}
	: ${OPENVZ_URL:=${OPENVZ_URL:-"http://www.openvz.org"}}
	: ${OPENVZ_INF:=${OPENVZ_INF:-"${YELLOW}RHEL6 kernel with OpenVZ patchset version ${GREEN}${OPENVZ_VER}${YELLOW} from ${GREEN}${OPENVZ_URL}${NORMAL}"}}
}

geek-openvz_init_variables

HOMEPAGE="${HOMEPAGE} ${OPENVZ_URL}"

SRC_URI="${SRC_URI}
	openvz?	( ${OPENVZ_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
geek-openvz_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/patch-${OPENVZ_VER}-combined.gz" "${OPENVZ_INF}"

	ApplyUserPatch "openvz"

	# disable video4linux version 1 - deprecated as of linux-headers-2.6.38:
	# http://forums.gentoo.org/viewtopic-t-872167.html?sid=60f2e6e08cf1f2e99b3e61772a1dc276
	sed -i -e "s:video4linux/::g" Documentation/Makefile || die
	sed -i -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' Makefile || die
	cp "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/config-${KSV}-${OPENVZ_VER}.i686" arch/x86/configs/i386_defconfig || die
	cp "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/config-${KSV}-${OPENVZ_VER}.x86_64" arch/x86/configs/x86_64_defconfig || die
	rm -f .config >/dev/null
	local GENTOOARCH="${ARCH}"
	unset ARCH
	make -s mrproper || die "make mrproper failed"
	make -s include/linux/version.h || die "make include/linux/version.h failed"
	ARCH="${GENTOOARCH}"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
geek-openvz_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${OPENVZ_INF}"
	einfo "${BLUE}This OpenVZ kernel uses RHEL6 (Red Hat Enterprise Linux 6) patch set.
This patch set is maintained by Red Hat for enterprise use, and contains
further modifications by the OpenVZ development team.

Red Hat typically only ensures that their kernels build using their
own official kernel configurations. Significant variations from these
configurations can result in build failures.

For best results, always start with a .config provided by the OpenVZ 
team from:${NORMAL}

${GREEN}http://wiki.openvz.org/Download/kernel/rhel6/${OVZ_KERNEL}.${NORMAL}

${BLUE}On amd64 and x86 arches, one of these configurations has automatically been
enabled in the kernel source tree that was just installed for you.

Slight modifications to the kernel configuration necessary for booting
are usually fine. If you are using genkernel, the default configuration
should be sufficient for your needs.${NORMAL}"
}
