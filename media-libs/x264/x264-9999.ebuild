# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git multilib toolchain-funcs

EGIT_REPO_URI="git://git.videolan.org/x264.git"

DESCRIPTION="A free library for encoding H264/AVC video streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mp4 threads X"

RDEPEND="mp4? ( media-video/gpac )
	X? ( x11-libs/libX11 )"

DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.2 )
	x86? ( >=dev-lang/yasm-0.7.0 )
	x86-fbsd? ( >=dev-lang/yasm-0.6.2 )
	dev-util/pkgconfig
	!media-video/x264-encoder"

src_unpack() {
	git_src_unpack
	cd "${S}"
	EPATCH_OPTS="-l"
	epatch "${FILESDIR}/${PN}-nostrip.patch"

	# use git 1.6 command style
	sed -i -e "s:git-rev-list:git rev-list:g" \
			-e "s:git-status:git status:" \
			"${S}"/version.sh
}

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} --enable-debug"
	./configure --prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--enable-pic --enable-shared \
		"--extra-cflags=${CFLAGS}" \
		"--extra-ldflags=${LDFLAGS}" \
		"--extra-asflags=${ASFLAGS}" \
		$(use_enable X visualize) \
		$(use_enable threads pthread) \
		$(use_enable debug) \
		$(use_enable mp4 mp4-output) \
		${myconf} \
		|| die "configure failed"
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS doc/*txt
}
