# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

#PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

BINUTILS_RELEASE_VER=${PV}
BINUTILS_VER="${PV/_p*/}"
DATE_VERSION="${PV/*_p}"
DATE_YEAR="${DATE_VERSION:0:4}"
DATE_YEAR_L="${DATE_VERSION:2:2}"
DATE_MONTH="${DATE_VERSION:4:6}"
LINARO_VER="${BINUTILS_VER}-${DATE_YEAR}.${DATE_MONTH}"

DESCRIPTION="Tools necessary to build programs with Linaro patches"
SRC_URI="http://releases.linaro.org/${DATE_YEAR_L}.${DATE_MONTH}/components/toolchain/binutils-linaro/binutils-linaro-${LINARO_VER}.tar.bz2"

RESTRICT="mirror"

S=${WORKDIR}/${PN}-${LINARO_VER}
