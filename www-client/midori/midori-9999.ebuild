# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

if [[ ${PV} == 9999* ]]
then
	EGIT_REPO_URI="git://git.xfce.org/apps/midori"
	EGIT_PROJECT="midori"
	inherit multilib git gnome2-utils eutils
else
	SRC_URI="http://goodies.xfce.org/releases/midori/${P}.tar.bz2"
	inherit gnome2-utils eutils multilib
fi

KEYWORDS="~x86 ~amd64"

DESCRIPTION="A lightweight web browser"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"

LICENSE="LGPL-2"
SLOT="0"
IUSE="-doc gnome +html idn libnotify nls +sqlite +unique"

RDEPEND="libnotify? ( x11-libs/libnotify )
	>=net-libs/libsoup-2.26
	>=net-libs/webkit-gtk-1.1.1
	dev-libs/libxml2
	x11-libs/gtk+
	gnome? ( net-libs/libsoup[gnome] )
	idn? ( net-dns/libidn )
	sqlite? ( >=dev-db/sqlite-3.0 )
	unique? ( dev-libs/libunique )"

DEPEND="${RDEPEND}
	dev-lang/python
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	html? ( dev-python/docutils )
	nls? ( sys-devel/gettext )"

PATCHES=""

src_unpack()
{
	if [[ ${PV} == 9999* ]]
	then
		git_src_unpack
	else
		unpack ${A}
	fi
	cd ${S}
}

src_prepare()
{
	# fixes/updates
	if [[ x"${PATCHES}" != x ]]
	then
		for PATCH in ${PATCHES}
		do
			if [[ -f "${FILESDIR}/${PATCH}" ]] 
			then
				epatch "${FILESDIR}/${PATCH}" || die "epatch ${PATCH} failed"
			else
				die "patch ${FILESDIR}/${PATCH} not found"
			fi
		done
	fi
	# moving docs to version-specific directory
	sed -i -e "s:\${DOCDIR}/${PN}:\${DOCDIR}/${PF}/:g" wscript
	sed -i -e "s:/${PN}/user/midori.html:/${PF}/user/midori.html:g" midori/midori-browser.c
}

src_configure() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" ./waf \
		--prefix="/usr/" \
		--libdir="/usr/$(get_libdir)" \
		--disable-docs \
		$(use_enable doc apidocs) \
		$(use_enable html userdocs) \
		$(use_enable idn libidn) \
		$(use_enable nls nls) \
		$(use_enable sqlite) \
		$(use_enable unique) \
		configure || die "configure failed"
}

src_compile() {
	./waf build || die "build failed"
}

src_install() {
	DESTDIR=${D} ./waf install || die "install failed"
#	rm -r ${D}/usr/share/doc/${PN}
	dodoc AUTHORS ChangeLog INSTALL TODO || die "dodoc failed"
}

pkg_postinst() {
	#xfconf_pkg_postinst
	ewarn "Midori tends to crash due to bugs in WebKit."
	ewarn "Report bugs at http://www.twotoasts.de/bugs"
	einfo "Updating Icon Cache"
	gtk-update-icon-cache -q -f -t ${D}/usr/share/icons/hicolor
}
