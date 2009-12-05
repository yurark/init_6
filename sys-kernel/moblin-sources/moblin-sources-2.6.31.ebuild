# Copyright 2004-2009 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2

ETYPE="sources"
inherit kernel-2 eutils
detect_version
detect_arch

DESCRIPTION="Official moblin Linux Standard kernel sources"
RESTRICT="nomirror"
IUSE=""
UNIPATCH_STRICTORDER="yes"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://ftp.moblin.org/moblin/development/core/source/"
SRC_URI="${KERNEL_URI}"

KV_FULL=${KV_FULL/linux/moblin}
K_NOSETEXTRAVERSION="1"
EXTRAVERSION=${EXTRAVERSION/linux/moblin}
SLOT="${PV}"
S="${WORKDIR}/linux-${KV_FULL}"

src_unpack() {

	kernel-2_src_unpack
	cd "${S}"

	# manually set extraversion
	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" Makefile

	#epatch ${FILESDIR}/${PV}/patch-2.6.32-rc8.bz2

	#
	# Patch to add a "nonintconfig" option to the Makefile
	# needed for unattended builds
	#
	#epatch ${FILESDIR}/${PV}/linux-2.6-build-nonintconfig.patch


	# Kernel CVE patches - these go last in the backport section
	# no non-cve patches should go here!


	#
	# End of the "straight backport" patches
	#


	#
	# Patch to try mounting / before all devices (the mouse)
	# are done probing. This saves several seconds of boot time.
	#
	epatch ${FILESDIR}/${PV}/linux-2.6.29-dont-wait-for-mouse.patch
	#
	# Patch to support the old sreadahead versions
	# To be removed before Moblin beta
	#
	#epatch ${FILESDIR}/${PV}/linux-2.6.29-sreadahead.patch
	#
	# KMS (note: upstream backports go in the backport section higher up!)
	#
	epatch ${FILESDIR}/${PV}/linux-2.6.29-kms-edid-cache.patch
	epatch ${FILESDIR}/${PV}/linux-2.6.29-kms-run-async.patch
	epatch ${FILESDIR}/${PV}/linux-2.6.29-kms-dont-blank-display.patch
	epatch ${FILESDIR}/${PV}/linux-2.6.29-kms-after-sata.patch

	#
	# Quiet down some printks that shows up falsly during boot
	#
	epatch ${FILESDIR}/${PV}/linux-2.6.29-silence-acer-message.patch
	epatch ${FILESDIR}/${PV}/linux-2.6.31-silence-wacom.patch



	# Tune ext3's default commit interval to 15 seconds
	# to be more gentle to SSDs
	#
	epatch ${FILESDIR}/${PV}/linux-2.6.29-jbd-longer-commit-interval.patch

	#
	# USB Selective Suspend patches
	#
	epatch ${FILESDIR}/${PV}/linux-2.6-driver-level-usb-autosuspend.patch
	epatch ${FILESDIR}/${PV}/linux-2.6-usb-uvc-autosuspend.patch

	#
	# Patches to help PowerTOP
	#
	epatch ${FILESDIR}/${PV}/linux-2.6.33-vfs-tracepoints.patch
	epatch ${FILESDIR}/${PV}/linux-2.6.33-alsa-powertop.patch
	#epatch ${FILESDIR}/${PV}/linux-2.6.33-ahci-alpm-accounting.patch

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
	#cd "${D}/usr/src/linux-${KV_FULL}"
	#local oldarch=${ARCH}
	#cp ${FILESDIR}/${P/-sources}-${ARCH}.config .config || die "cannot copy kernel config"
	#unset ARCH
	#make modules_prepare || die "failed to run modules_prepare"
	#rm .config
	#ARCH=${oldarch}

}
