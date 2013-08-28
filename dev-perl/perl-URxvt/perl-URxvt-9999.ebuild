# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit git

DESCRIPTION="Perl extensions for Rxvt-unicode terminal emulator"
HOMEPAGE="https://github.com/muennich/urxvt-perls"
EGIT_REPO_URI="git://github.com/muennich/urxvt-perls.git"
EGIT_PROJECT=${PN}.git

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND} x11-terms/rxvt-unicode
	|| ( x11-misc/xsel x11-misc/xclip )"

src_install() {
	insinto /usr/lib/urxvt/perl/
	doins clipboard keyboard-select url-select || die
	dodoc README.md
}
