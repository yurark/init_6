# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools gnome2 flag-o-matic python

DESCRIPTION="Integrated mail, addressbook and calendaring functionality"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2.0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="crypt dbus hal kerberos krb4 ldap mono networkmanager nntp pda profile python ssl gstreamer exchange"
# pst

# Pango dependency required to avoid font rendering problems
# We need a graphical pinentry frontend to be able to ask for the GPG
# password from inside evolution, bug 160302
RDEPEND=">=dev-libs/glib-2.20
	>=x11-libs/gtk+-2.16
	>=gnome-extra/evolution-data-server-${PV}
	>=x11-themes/gnome-icon-theme-2.20
	>=gnome-base/libbonobo-2.20.3
	>=gnome-base/libbonoboui-2.4.2
	>=gnome-extra/gtkhtml-3.27.90
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnomeui-2
	>=dev-libs/libxml2-2.7.3
	>=dev-libs/libgweather-2.25.3
	>=x11-misc/shared-mime-info-0.22
	>=gnome-base/gnome-desktop-2.26.0
	dbus? ( >=dev-libs/dbus-glib-0.74 )
	hal? ( >=sys-apps/hal-0.5.4 )
	x11-libs/libnotify
	pda? (
		>=app-pda/gnome-pilot-2.0.15
		>=app-pda/gnome-pilot-conduits-2 )
	dev-libs/atk
	ssl? (
		>=dev-libs/nspr-4.6.1
		>=dev-libs/nss-3.11 )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	>=net-libs/libsoup-2.4
	kerberos? ( virtual/krb5 )
	krb4? ( app-crypt/mit-krb5[krb4] )
	>=gnome-base/orbit-2.9.8
	crypt? ( || (
				  ( >=app-crypt/gnupg-2.0.1-r2
					|| ( app-crypt/pinentry[gtk] app-crypt/pinentry[qt3] ) )
				  =app-crypt/gnupg-1.4* ) )
	ldap? ( >=net-nds/openldap-2 )
	mono? ( >=dev-lang/mono-1 )
	python? ( >=dev-lang/python-2.4 )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10 )"
# Disabled until API stabilizes
#	pst? ( >=net-mail/libpst-0.6.41 )

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.16
	>=dev-util/intltool-0.35.5
	sys-devel/gettext
	sys-devel/bison
	app-text/scrollkeeper
	>=gnome-base/gnome-common-2.12.0
	>=app-text/gnome-doc-utils-0.9.1"

PDEPEND="exchange? ( >=gnome-extra/evolution-exchange-2.26.1 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS* README"
ELTCONF="--reverse-deps"

pkg_setup() {
	G2CONF="${G2CONF}
		--without-kde-applnk-path
		--enable-plugins=experimental
		--with-weather
		$(use_enable ssl nss)
		$(use_enable ssl smime)
		$(use_enable mono)
		$(use_enable nntp)
		$(use_enable networkmanager nm)
		$(use_enable dbus)
		$(use_enable gstreamer audio-inline)
		$(use_enable exchange)
		--disable-pst-import
		$(use_enable pda pilot-conduits)
		$(use_enable profile profiling)
		$(use_enable python)
		$(use_with ldap openldap)
		$(use_with kerberos krb5 /usr)
		$(use_with krb4 krb4 /usr)"

	# dang - I've changed this to do --enable-plugins=experimental.  This will
	# autodetect new-mail-notify and exchange, but that cannot be helped for the
	# moment.  They should be changed to depend on a --enable-<foo> like mono
	# is.  This cleans up a ton of crap from this ebuild.
}

src_prepare() {
	gnome2_src_prepare

	# PATCH-NEEDS-REBASE calendar-sendbutton.patch -- It also needs a proper description and a bug number
	#epatch "${FILESDIR}/${PN}-2.28.2-calendar-sendbutton.patch"
	epatch "${FILESDIR}/${PN}-2.28.2-fix-exchange-menuitem.diff"
	# PATCH-FIX-OPENSUSE evolution-custom-openldap-includes.patch maw@novell.com -- look for ldap includes in %{_libdir}/evoldap/include
	EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-custom-openldap-includes.patch"
	# PATCH-FEATURE-OPENSUSE evolution-shared-nss-db.patch hpj@novell.com -- Migrate to shared NSS database.
	#EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-shared-nss-db.patch"
	# PATCH-FIX-UPSTREAM  bnc-435668-hide-accept.patch bnc#435668 -- Meetings In SentItems Should Hide Accept/Decline.
	epatch "${FILESDIR}/${PN}-2.28.2-bnc-435668-hide-accept.patch"
	# PATCH-FIX-UPSTREAM bnc-435722-book-uri-long.patch bnc#435722 abharath@suse.de -- Book URI: Spills Into Second Column.
	epatch "${FILESDIR}/${PN}-2.28.2-bnc-435722-book-uri-long.patch"
	# PATCH-FIX-UPSTREAM sharepoint-account-setup.patch pchenthill@suse.de -- This patch allows you to connect to sharepoint servers.
	EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-sharepoint-account-setup.patch"
	# PATCH-FIX-OPENSUSE bnc-433448-backup-restore-fails.patch bnc433448 abharath@suse.de -- Not required upstream.
	epatch "${FILESDIR}/${PN}-2.28.2-bnc-433448-backup-restore-fails.patch"
	# PATCH-FIX-UPSTREAM bnc-210959-evo-accept-ics.patch bnc210959 pchenthill@novell.com -- Patch yet to be pushed upstream.
	epatch "${FILESDIR}/${PN}-2.28.2-bnc-210959-evo-accept-ics.patch"
	# PATCH-FIX-UPSTREAM sp-tasks-setup.diff pchenthill@suse.de -- Patch needs to be upstreamed. 
	EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-sp-tasks-setup.diff"
	# PATCH-FIX-UPSTREAM sp-meetingworkspace-ui.patch pchenthill@suse.de -- Patch needs to be upstreamed.
	EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-sp-meetingworkspace-ui.patch"
	# PATCH-FIX-UPSTREAM bnc-449888-handle-no-workspace.patch bnc449888 pchenthill@suse.de -- Patch needs to be upstreamed.
	EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-bnc-449888-handle-no-workspace.patch"
	# PATCH-FIX-SLED bnc-440634-forwarded-hide-accept-decline.patch bnc440634 abharath@suse.de -- Make GW understand folders better.
	epatch "${FILESDIR}/${PN}-2.28.2-bnc-440634-forwarded-hide-accept-decline.patch"
	# PATCH-NEEDS-REBASE bnc-445996-address-conflict.patch bnc445996 shashish@suse.de -- Needs to be moved out of glade files. (was PATCH-FIX-SLED)
	#epatch "${FILESDIR}/${PN}-2.28.2-bnc-445996-address-conflict.patch"
	# PATCH-FIX-SLED sp-process-meetings.diff pchenthill@suse.de -- Fix for bug 449899 (bnc)
	#EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-sp-process-meetings.diff"
	# PATCH-FIX-UPSTREAM evolution-as-needed.patch bgo#589393 dominique-obs@leuenberger.net -- Fix configure with --as-needed
	#EPATCH_OPTS="-p1" epatch "${FILESDIR}/${PN}-2.28.2-evolution-as-needed.patch"

	# FIXME: Fix compilation flags crazyness
	sed 's/CFLAGS="$CFLAGS $WARNING_FLAGS"//' \
		-i configure.ac configure || die "sed 1 failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf

	# Use NSS/NSPR only if 'ssl' is enabled.
	if use ssl ; then
		sed -i -e "s|mozilla-nss|nss|
			s|mozilla-nspr|nspr|" "${S}"/configure || die "sed 1 failed"
		G2CONF="${G2CONF} --enable-nss=yes"
	else
		G2CONF="${G2CONF} --without-nspr-libs --without-nspr-includes \
			--without-nss-libs --without-nss-includes"
	fi

	# problems with -O3 on gcc-3.3.1
	replace-flags -O3 -O2
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "To change the default browser if you are not using GNOME, do:"
	elog "gconftool-2 --set /desktop/gnome/url-handlers/http/command -t string 'mozilla %s'"
	elog "gconftool-2 --set /desktop/gnome/url-handlers/https/command -t string 'mozilla %s'"
	elog ""
	elog "Replace 'mozilla %s' with which ever browser you use."
	elog ""
	elog "Junk filters are now a run-time choice. You will get a choice of"
	elog "bogofilter or spamassassin based on which you have installed"
	elog ""
	elog "You have to install one of these for the spam filtering to actually work"
}
