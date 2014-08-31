# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
SLOT="0"
ETYPE="sources"

inherit kernel-2
detect_version

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"

if [[ ${PV} == "9999" ]] ; then
	CKV=`date +%F`
	K_DEBLOB_AVAILABLE="0"
	inherit git-r3
	EGIT_REPO_URI="git://github.com/torvalds/linux.git"
	EGIT_PROJECT="linux"
	SRC_URI=""
else
	K_DEBLOB_AVAILABLE="1"
	SRC_URI="${KERNEL_URI}"
fi

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"

KEYWORDS="~amd64 ~x86"
IUSE="deblob"
