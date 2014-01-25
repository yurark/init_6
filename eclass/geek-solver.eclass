# Copyright 2011-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v3
# $Header: $

# @ECLASS: geek-solver.eclass
# This file is part of sys-kernel/geek-sources project.
# @MAINTAINER:
# Andrey Ovcharov <sudormrfhalt@gmail.com>
# @AUTHOR:
# Original author: Andrey Ovcharov <sudormrfhalt@gmail.com> (19 Nov 2013)
# @LICENSE: http://www.gnu.org/licenses/gpl-3.0.html GNU GPL v3
# @BLURB: Eclass for solve patch versions problem.
# @DESCRIPTION:
# This eclass provides functionality and default ebuild variables for solve
# problems with versions of the patches

# The latest version of this software can be obtained here:
# https://github.com/init6/init_6/blob/master/eclass/geek-solver.eclass
# Bugs: https://github.com/init6/init_6/issues
# Wiki: https://github.com/init6/init_6/wiki/geek-sources

#inherit geek-patch geek-utils geek-vars

#EXPORT_FUNCTIONS mlsr_sort vercmp

# Compare two numbers as fractional parts of a decimal fraction.
function comm_float() {
	local f1="$1" f2="$2" i d1 d2
	for ((i=0;i<${#f1}||i<${#f2};++i)); do
		d1=${f1:$i:1}; [[ "$d1" ]] || d1=0
		d2=${f2:$i:1}; [[ "$d2" ]] || d2=0
		((d1<d2)) && return -- -7; ((d1>d2)) && return -- 7;
	done
	return 0
}

# Compare version specifiers s1, s2. Returns <0, 0, >0 if s1 is resp lower,
# equal, higher than s2. Note that <0 actually means >127 (-1 -> 255, etc)
# 0: equal; 1: differ in erev; 2: differ in status number; 3: differ in status;
# 4: differ in letter; 5: differ in mmm length; 6: differ in mmm
#
# This needs to be kept equivalent to portage_versions.vercmp().
#
# NOTE: Portage considers e.g. 7.0 and 7.0.0 to be equivalent. Yes, I know,
# this sucks. HATE HATE HATE
#
# status code number: alpha->0, beta->1, pre->2, rc->3, (none)->4, p->5
function comm_ver() {
	local s1_mlsr="$1" s2_mlsr="$2"
	[[ "$s1_mlsr" == "$s2_mlsr" ]] && return 0
	if [[ "$s1_mlsr" == */* || "$s2_mlsr" == */* ]]; then
		echo "Oops: comm_ver called with category/package: $s1_mlsr $s2_mlsr" #| format_error >&2
#		backtrace
		return 0
	fi
	s1_mls="${s1_mlsr/%-r+([[:digit:]])}"; s1_r="${s1_mlsr#${s1_mls}}"
	s1_r="${s1_r/#-r*(0)}"
	s1_ml="${s1_mls%%*(_@(alpha|beta|pre|rc|p)*([[:digit:]]))}"
	s1_ss="${s1_mls#${s1_ml}}"
	s1_m="${s1_ml/%[[:lower:]]}"; s1_l="${s1_ml#${s1_m}}"; s1_m=( ${s1_m//./ } )
	s2_mls="${s2_mlsr/%-r+([[:digit:]])}"; s2_r="${s2_mlsr#${s2_mls}}"
	s2_r="${s2_r/#-r*(0)}"
	s2_ml="${s2_mls%%*(_@(alpha|beta|pre|rc|p)*([[:digit:]]))}"
	s2_ss="${s2_mls#${s2_ml}}"
	s2_m="${s2_ml/%[[:lower:]]}"; s2_l="${s2_ml#${s2_m}}"; s2_m=( ${s2_m//./ } )
	local i
	for ((i=0; i<${#s1_m[@]} || i<${#s2_m[@]}; ++i)); do
		s1mi="${s1_m[$i]}"; s2mi="${s2_m[$i]}"
		[[ "$s1mi" || "$s2mi" == '0' ]] || return -- -5
		[[ "$s2mi" || "$s1mi" == '0' ]] || return -- 5
		if [[ "$s1mi" == 0* || "$s2mi" == 0* ]]; then
			comm_float "$s1mi" "$s2mi"; ret=$?; ((ret)) && return -- $ret
		else
			((s1mi < s2mi)) && return -- -6
			((s1mi > s2mi)) && return -- 6
		fi
	done
	((${#s1_m[@]}!=${#s2_m[@]})) && [[ "${s1_l}${s1_s}${s1_r}" == "${s2_l}${s2_s}${s2_r}" ]] && return 0
	[[ "$s1_l" < "$s2_l" ]] && return -- -4
	[[ "$s1_l" > "$s2_l" ]] && return -- 4
	s1_ss=( ${s1_ss//_/ } ); s2_ss=( ${s2_ss//_/ } )
	for ((i=0; i<${#s1_ss[@]} || i<${#s2_ss[@]}; ++i)); do
		s1si="${s1_ss[$i]}"; s2si="${s2_ss[$i]}"
		s1sci="${s1si/%*([[:digit:]])}"; s2sci="${s2si/%*([[:digit:]])}"
		s1_scn="$((6-${#s1sci}))"; [[ $s1_scn -ge 4 ]] && s1_scn=$((10-$s1_scn))
		s2_scn="$((6-${#s2sci}))"; [[ $s2_scn -ge 4 ]] && s2_scn=$((10-$s2_scn))
		[[ "$s1_scn" < "$s2_scn" ]] && return -- -3
		[[ "$s1_scn" > "$s2_scn" ]] && return -- 3
		s1_sn="${s1si##${s1sci}*(0)}"
		s2_sn="${s2si##${s2sci}*(0)}"
		[[ "$s1_sn" -lt "$s2_sn" ]] && return -- -2
		[[ "$s1_sn" -gt "$s2_sn" ]] && return -- 2
	done
	[[ "${s1_r}" -lt "${s2_r}" ]] && return -- -1
	[[ "${s1_r}" -gt "${s2_r}" ]] && return -- 1
	echo "Error! comm_ver failed $1 $2" >&2
	exit 128	# should not reach here
}

# function geek-solver_vercmp() {
function vercmp() {
	comm_ver "$1" "$3"
	case "$2" in
		"=" ) (( $? == 0 ));;
		"~" ) (( $? == 255 || $? == 0 || $? == 1 ));;
		"<=" ) (( $? == 0 || $? >= 128 ));;
		"<" ) (( $? >= 128 ));;
		">=" ) (( $? < 128 ));;
		">" ) (( $? > 0 && $? < 128 ));;
		* ) einfo "Unrecognised version comparator: $2" >&2
	esac
}

function method_sort() {
	# An insertion sort, or something like it: we expect the input list to
	# be largely sorted so want to compare new elements to the top end of
	# the partial list.
	# <method>: a function which returns true if $1 sorts after $2.
	local -a method=( "$@" )
	read x && local -a list[0]="$x" || return -- 1
	while read x; do
		local i
		for ((i = ${#list[@]} - 1; i >= 0; --i)); do
			"${method[@]}" "$x" "${list[i]}" && break
		done \
		&& list=("${list[@]:0:i+1}" "$x" "${list[@]:i+1}") \
		|| list=("$x" "${list[@]}")
	done
	for x in "${list[@]}"; do cat <<<"$x"; done
}

function is_ver_higher() {
	# vercmp "${1% *}" ">" "${2% *}"
	comm_ver "${1% *}" "${2% *}"; (( $? > 0 && $? < 128 ))
}

# function geek-solver_mlsr_sort() {
function mlsr_sort() {
	method_sort is_ver_higher
}
