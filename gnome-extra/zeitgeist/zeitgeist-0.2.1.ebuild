# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

DESCRIPTION="A service that logs the users activities and determines which files are relevant to one another"
HOMEPAGE="https://launchpad.net/zeitgeist"
SRC_URI="http://launchpad.net/zeitgeist/0.2/0.2.1/+download/zeitgeist_0.2.1.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.14
	dev-python/pygobject
	dev-python/dbus-python
	dev-python/storm"
DEPEND="${RDEPEND}
		>=dev-util/intltool-0.35
		>=sys-devel/gettext-0.14"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README TODO
}

pkg_postinst() {
	python_need_rebuild
	python_mod_optimize $(python_get_sitedir)/zeitgeist
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/zeitgeist
}

