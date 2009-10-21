# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="Meta package for a typical Gentoo desktop using GNOME, merge this package to install"
HOMEPAGE="http://dev.gentooexperimental.org/~bheekling/"
LICENSE="as-is"
SLOT="0"
IUSE="applets archives bluetooth +console dev extras games +fancy +fonts +laptop
mobile net p2p +portage pulseaudio scim +splash +vcs"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~amd64 ~x86"

RDEPEND="gnome-base/gnome-light

	media-gfx/eog
	app-crypt/seahorse
	app-text/evince[djvu,dvi,t1lib]
	gnome-base/gdm
	|| ( mail-client/evolution
		 mail-client/mozilla-thunderbird-bin
		 mail-client/mozilla-thunderbird )
	|| ( gnome-extra/nautilus-cd-burner
		 app-cdr/brasero )
	media-fonts/dejavu

	>=www-client/mozilla-firefox-3
	www-plugins/adobe-flash
	net-im/pidgin
	net-irc/conspire
	app-dicts/myspell-en
	|| ( app-editors/leafpad
		 app-editors/gedit
		 app-editors/gvim )

	applets? ( gnome-base/gnome-applets )

	archives? ( app-arch/file-roller
				app-arch/p7zip
				app-arch/unrar
				app-arch/lzma-utils )

	bluetooth? ( || ( net-wireless/bluez-gnome
					  net-wireless/gnome-bluetooth )
				 gnome-base/gvfs[bluetooth] )

	console? ( app-shells/gentoo-bashcomp
			   app-misc/screen
			   app-editors/vim
			   sys-process/htop
			   sys-process/iotop )

	dev? ( dev-util/strace
		   dev-util/ltrace
		   sys-devel/gdb
		   dev-util/devhelp )

	extras? ( gnome-extra/gconf-editor
			  gnome-extra/gnome-screensaver
			  media-sound/rhythmbox
			  media-libs/gst-plugins-bad
			  gnome-extra/gnome-utils )

	fancy? ( x11-wm/compiz-fusion
			 x11-themes/gnome-backgrounds
			 x11-themes/tango-icon-theme
			 x11-themes/vanilla-dmz-xcursors
			 x11-themes/sound-theme-freedesktop )

	fonts? ( media-fonts/lohit-fonts
			 media-fonts/liberation-fonts
			 media-fonts/font-adobe-75dpi )

	games? ( gnome-extra/gnome-games[X,artworkextra,guile,opengl]
			 games-misc/fortune-mod
			 games-misc/cowsay )

	laptop? ( sys-apps/hal[laptop]
			  sys-apps/smartmontools
			  sys-power/pm-utils
			  sys-power/powertop
			  gnome-extra/gnome-power-manager
			  gnome-extra/sensors-applet )

	mobile? ( net? ( net-dialup/wvdial ) )

	net? ( dev? ( net-analyzer/nmap
				  net-analyzer/iftop
				  net-analyzer/tcpdump )
		   net-dialup/ppp
		   net-analyzer/macchanger )

	office? ( || ( ( || ( app-office/openoffice-bin
						  app-office/openoffice ) )
				   ( app-office/abiword
					 app-office/gnumeric ) ) )
	
	p2p? ( net-p2p/transmission
		   net-p2p/linuxdcpp )

	portage? ( app-portage/eix
			   app-portage/genlop
			   app-portage/gentoolkit
			   dev? ( app-portage/gentoolkit-dev
					  app-portage/portage-utils )
			   app-portage/layman
			   dev-util/ccache )

	pulseaudio? ( extras? ( media-sound/pavucontrol
							media-sound/padevchooser
							media-sound/paprefs
							media-sound/paman )
				  media-libs/libao
				  media-plugins/gst-plugins-pulse )

	science? ( dev-python/matplotlib )

	scim? ( app-i18n/freewnn
			app-i18n/scim-anthy )

	splash? ( media-gfx/splash-themes-livecd
			  media-gfx/splashutils
			  sys-apps/v86d )

	vcs? ( dev-util/giggle
		   dev-util/git
		   dev-util/cvs
		   dev-util/subversion )
"

pkg_postinst() {
	elog "Check the USE flags and merge to get what you need."
	if use pulseaudio; then
		elog "Check that swfdec is compiled with USE -alsa and +pulseaudio"
	fi
}
