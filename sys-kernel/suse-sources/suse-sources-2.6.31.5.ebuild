# Copyright 2004-2009 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Official SuSE Linux Standard kernel sources"
RESTRICT="nomirror"
IUSE=""
UNIPATCH_STRICTORDER="yes"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.opensuse.org"
SRC_URI="${KERNEL_URI}"

KV_FULL=${KV_FULL/linux/suse}
K_NOSETEXTRAVERSION="1"
EXTRAVERSION=${EXTRAVERSION/linux/suse}
SLOT="${PV}"
S="${WORKDIR}/linux-${KV_FULL}"

src_unpack() {

	kernel-2_src_unpack
	cd "${S}"

	# manually set extraversion
	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile

	epatch ${FILESDIR}/${PV}/suse-2.6.32-rc5-git3-1.2.patch
}

src_install() {

	local version_h_name="usr/src/linux-${KV_FULL}/include/linux"
	local version_h="${ROOT}${version_h_name}"
	if [ -f "${version_h}" ]; then
		einfo "Discarding previously installed version.h to avoid collisions"
		addwrite "/${version_h_name}"
		rm -f "${version_h}"
	fi

	kernel-2_src_install
	cd "${D}/usr/src/linux-${KV_FULL}"
	#local oldarch=${ARCH}
	#cp ${FILESDIR}/${P/-sources}-${ARCH}.config .config || die "cannot copy kernel config"
	#unset ARCH
	make modules_prepare || die "failed to run modules_prepare"
	#rm .config
	ARCH=${oldarch}

}
