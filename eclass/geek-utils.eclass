# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-utils.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (12 Aug 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass with utils for building kernel.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for building
# kernel.

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-utils.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

EXPORT_FUNCTIONS use_if_iuse get_from_url git_get_all_branches git_checkout find_crap rm_crap get_config set_1k_HZ_ticks disable_NUMA set_BFQ copy move

# @FUNCTION: in_iuse
# @USAGE: <flag>
# @DESCRIPTION:
# Determines whether the given flag is in IUSE. Strips IUSE default prefixes
# as necessary.
#
# Note that this function should not be used in the global scope.
in_iuse() {
	debug-print-function ${FUNCNAME} "${@}"

	[[ ${#} -eq 1 ]] || die "Invalid args to ${FUNCNAME}()"

	local flag=${1}
	local liuse=( ${IUSE} )

	has "${flag}" "${liuse[@]#[+-]}"
}

# @FUNCTION: use_if_iuse
# @USAGE: <flag>
# @DESCRIPTION:
# Return true if the given flag is in USE and IUSE.
#
# Note that this function should not be used in the global scope.
geek-utils_use_if_iuse() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -ne 1 ]] && die "Invalid number of args to ${FUNCNAME}()";

	in_iuse $1 || return 1
	use $1
}

# @FUNCTION: get_from_url
# @USAGE:
# @DESCRIPTION:
geek-utils_get_from_url() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -ne 2 ]] && die "Invalid number of args to ${FUNCNAME}()";

	local url="$1"
	local release="$2"
	shift
	wget -nd --no-parent --level 1 -r -R "*.html*" --reject "$release" \
	"$url/$release" > /dev/null 2>&1
}

# @FUNCTION: git_get_all_branches
# @USAGE:
# @DESCRIPTION:
geek-utils_git_get_all_branches(){
	debug-print-function ${FUNCNAME} "$@"

	for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
		git branch --track ${branch##*/} ${branch} > /dev/null 2>&1
	done
}

# @FUNCTION: git_checkout
# @USAGE:
# @DESCRIPTION:
geek-utils_git_checkout(){
	debug-print-function ${FUNCNAME} "$@"

	local branch_name=${1:-master}

	pushd "${EGIT_SOURCEDIR}" > /dev/null

	debug-print "${FUNCNAME}: git checkout ${branch_name}"
	git checkout ${branch_name}

	popd > /dev/null
}

# iternal function
#
# @FUNCTION: find_crap
# @USAGE:
# @DESCRIPTION: Find *.orig or *.rej files
geek-utils_find_crap() {
	debug-print-function ${FUNCNAME} "$@"

	if [ $(find "${S}" \( -name \*.orig -o -name \*.rej \) | wc -c) -eq 0 ]; then
		crap="0"
	else
		crap="1"
	fi
}

# iternal function
#
# @FUNCTION: rm_crap
# @USAGE:
# @DESCRIPTION: Remove *.orig or *.rej files
geek-utils_rm_crap() {
	debug-print-function ${FUNCNAME} "$@"

	find "${S}" \( -name \*~ -o -name \.gitignore -o -name \*.orig -o -name \.*.orig -o -name \*.rej -o -name \*.old -o -name \.*.old \) -delete
}

# @FUNCTION: get_config
# @USAGE:
# @DESCRIPTION:
geek-utils_get_config() {
	debug-print-function ${FUNCNAME} "$@"

	ebegin "Searching for best availiable kernel config"
		if [ -r "/proc/config.gz" ]; then test -d .config >/dev/null 2>&1 || zcat /proc/config.gz > .config
			einfo " ${BLUE}Found config from running kernel, updating to match target kernel${NORMAL}"
		elif [ -r "/boot/config-${FULLVER}" ]; then test -d .config >/dev/null 2>&1 || cat "/boot/config-${FULLVER}" > .config
			einfo " ${BLUE}Found${NORMAL} ${RED}/boot/config-${FULLVER}${NORMAL}"
		elif [ -r "/etc/portage/savedconfig/${CATEGORY}/${PN}/config" ]; then test -d .config >/dev/null 2>&1 || cat /etc/portage/savedconfig/${CATEGORY}/${PN}/config > .config
			einfo " ${BLUE}Found${NORMAL} ${RED}/etc/portage/savedconfig/${CATEGORY}/${PN}/config${NORMAL}"
		elif [ -r "/usr/src/linux/.config" ]; then test -d .config >/dev/null 2>&1 || cat /usr/src/linux/.config > .config
			einfo " ${BLUE}Found${NORMAL} ${RED}/usr/src/linux/.config${NORMAL}"
		elif [ -r "/usr/src/linux-${KV_FULL}/.config" ]; then test -d .config >/dev/null 2>&1 || cat /usr/src/linux-${KV_FULL}/.config > .config
			einfo " ${BLUE}Found${NORMAL} ${RED}/usr/src/linux-${KV_FULL}/.config${NORMAL}"
		else test -d .config >/dev/null 2>&1 || cp arch/${ARCH}/defconfig .config \
			einfo " ${BLUE}No suitable custom config found, defaulting to defconfig${NORMAL}"
		fi
	eend $?
}

# @FUNCTION: set_1k_HZ_ticks
# @USAGE:
# @DESCRIPTION:
# Optionally set tickrate to 1000 to avoid suspend issues as reported here:
# http://ck-hack.blogspot.com/2013/09/bfs-0441-311-ck1.html?showComment=1379234249615#c4156123736313039413
geek-utils_set_1k_HZ_ticks() {
	debug-print-function ${FUNCNAME} "$@"

	if [ "${enable_1k_HZ_ticks}" = "yes" ]; then # Set tick rate to 1k ...
		sed -i -e 's/^CONFIG_HZ_300=y/# CONFIG_HZ_300 is not set/' \
			-i -e 's/^# CONFIG_HZ_1000 is not set/CONFIG_HZ_1000=y/' \
			-i -e 's/^CONFIG_HZ=300/CONFIG_HZ=1000/' .config
	fi
}

# @FUNCTION: disable_NUMA
# @USAGE:
# @DESCRIPTION:
# Optionally disable NUMA since >99% of users have mono-socket systems.
# For more, see: https://bugs.archlinux.org/task/31187
geek-utils_disable_NUMA() {
	debug-print-function ${FUNCNAME} "$@"

	if [ "${disable_NUMA}" = "yes" ]; then
		if [ "${ARCH}" = "amd64" ]; then # Disabling NUMA from kernel config ...
			sed -i -e 's/CONFIG_NUMA=y/# CONFIG_NUMA is not set/' \
				-i -e '/CONFIG_AMD_NUMA=y/d' \
				-i -e '/CONFIG_X86_64_ACPI_NUMA=y/d' \
				-i -e '/CONFIG_NODES_SPAN_OTHER_NODES=y/d' \
				-i -e '/# CONFIG_NUMA_EMU is not set/d' \
				-i -e '/CONFIG_NODES_SHIFT=6/d' \
				-i -e '/CONFIG_NEED_MULTIPLE_NODES=y/d' \
				-i -e '/# CONFIG_MOVABLE_NODE is not set/d' \
				-i -e '/CONFIG_USE_PERCPU_NUMA_NODE_ID=y/d' \
				-i -e '/CONFIG_ACPI_NUMA=y/d' .config
		fi
	fi
}

# @FUNCTION: set_BFQ
# @USAGE:
# @DESCRIPTION:
# Optionally enable BFQ as the default I/O scheduler
geek-utils_set_BFQ() {
	debug-print-function ${FUNCNAME} "$@"

	if [ "${enable_BFQ}" = "yes" ]; then # Set BFQ as default I/O scheduler ...
		sed -i -e '/CONFIG_DEFAULT_IOSCHED/ s,cfq,bfq,' \
			-i -e s'/CONFIG_DEFAULT_CFQ=y/# CONFIG_DEFAULT_CFQ is not set\nCONFIG_DEFAULT_BFQ=y/' .config
	fi
}

# @FUNCTION: copy
# @USAGE:
# @DESCRIPTION:
geek-utils_copy() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -ne 2 ]] && die "Invalid number of args to ${FUNCNAME}()";

	local src=${1}
	local dst=${2}

#	cp "${src}" "${dst}" || die "${RED}cp ${src} ${dst} failed${NORMAL}"
#	rsync -avhW --no-compress --progress "${src}" "${dst}" || die "${RED}rsync -avhW --no-compress --progress ${src} ${dst} failed${NORMAL}"
	test -d "${dst}" >/dev/null 2>&1 || mkdir -p "${dst}"; (cd "${src}"; tar cf - .) | (cd "${dst}"; tar xpf -) || die "${RED}cp ${src} ${dst} failed${NORMAL}"
}

# @FUNCTION: move
# @USAGE:
# @DESCRIPTION:
geek-utils_move() {
	debug-print-function ${FUNCNAME} "$@"

	[[ ${#} -ne 2 ]] && die "Invalid number of args to ${FUNCNAME}()";

	local src=${1}
	local dst=${2}

	(copy ${src} ${dst} >/dev/null 2>&1 && rm -rf "${src}") || die "${RED}mv ${src} ${dst} failed${NORMAL}"
}
