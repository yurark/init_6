# Copyright 2009-2014 Andrey Ovcharov <sudormrfhalt@gmail.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit multilib

DESCRIPTION="Scroll wheel support for urxvt"
HOMEPAGE="https://aur.archlinux.org/packages/urxvt-vtwheel/"
SRC_URI="http://dev.gentoo.org/~dastergon/distfiles/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-terms/rxvt-unicode[perl]"

src_install() {
	insinto /usr/$(get_libdir)/urxvt/perl
	doins vtwheel
}
