# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: bfs.eclass
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
# https://github.com/init6/init_6/blob/master/eclass/ck.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

case ${EAPI} in
	5)	: ;;
	*)	die "bfs.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

if [[ ${___ECLASS_ONCE_BFS} != "recur -_+^+_- spank" ]]; then
___ECLASS_ONCE_BFS="recur -_+^+_- spank"

inherit patch utils vars

EXPORT_FUNCTIONS src_prepare pkg_postinst

# @FUNCTION: init_variables
# @INTERNAL
# @DESCRIPTION:
# Internal function initializing all variables.
# We define it in function scope so user can define
# all the variables before and after inherit.
bfs_init_variables() {
	debug-print-function ${FUNCNAME} "$@"

	: ${BFS_VER:=${BFS_VER:-"462"}} # Patchset version
	: ${BFS_SRC:=${BFS_SRC:-"http://ck.kolivas.org/patches/bfs/$(echo ${KMV} | cut -f 1 -d .).0/${KMV}/${KMV}-sched-bfs-${BFS_VER}.patch"}} # Patchset sources url
	: ${BFS_URL:=${BFS_URL:-"http://users.on.net/~ckolivas/kernel"}} # Patchset url
	: ${BFS_INF:=${BFS_INF:-"${YELLOW}Con Kolivas' kernel scheduler to improve multitasking in low performance PCs version ${GREEN}${BFS_VER}${YELLOW} from ${GREEN}${BFS_URL}${NORMAL}"}}

	debug-print "${FUNCNAME}: BFS_VER=${BFS_VER}"
	debug-print "${FUNCNAME}: BFS_SRC=${BFS_SRC}"
	debug-print "${FUNCNAME}: BFS_URL=${BFS_URL}"
	debug-print "${FUNCNAME}: BFS_INF=${BFS_INF}"
}

bfs_init_variables

HOMEPAGE="${HOMEPAGE} ${BFS_URL}"

SRC_URI="${SRC_URI}
	bfs? ( ${BFS_SRC} )"

# @FUNCTION: src_prepare
# @USAGE:
# @DESCRIPTION: Prepare source packages and do any necessary patching or fixes.
bfs_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"

	ApplyPatch "${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/patch-${BFS_VER}.patch" "${BFS_INF}"
	ApplyUserPatch "bfs"
}

# @FUNCTION: pkg_postinst
# @USAGE:
# @DESCRIPTION: Called after image is installed to ${ROOT}
bfs_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"

	einfo "${BFS_INF}"
}

fi
