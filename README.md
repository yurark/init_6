init6 overlay
=============

At this unofficial place, i publish some ebuilds that may (or may not) be interesting to other Gentoo users.

**USE AT YOUR OWN RISK.**

You are supposed to be using **~amd64** or **~x86** if you use this overlay.
Please report any failure or missing dep.
You can also request to add any ebuild.

For add overlay
---------------

Install layman

    emerge -av layman; layman -L

and run

    layman -a init6

If you've never worked with a overlay, please read [Gentoo Overlays: Users' Guide](http://www.gentoo.org/proj/en/overlays/userguide.xml)

In this overlay you will find
-----------------------------
 * [app-admin/perl-cleaner](https://github.com/init6/init_6/tree/master/app-admin/perl-cleaner) [User land tool for cleaning up old perl installs](http://www.gentoo.org/proj/en/perl/) with my fix of [bug #373219](https://bugs.gentoo.org/show_bug.cgi?id=373219)
 * [app-admin/python-updater](https://github.com/init6/init_6/tree/master/app-admin/python-updater) [Script used to reinstall Python packages after changing of active Python versions](http://www.gentoo.org/proj/en/Python/) with my fix of [bug #373219](https://bugs.gentoo.org/show_bug.cgi?id=373219)
 * [app-misc/mc](https://github.com/init6/init_6/tree/master/app-misc/mc) [GNU Midnight Commander is a text based file manager](http://www.midnight-commander.org) with adb:// support
 * [app-portage/gentoolkit](https://github.com/init6/init_6/tree/master/app-portage/gentoolkit) [Collection of administration scripts for Gentoo](http://www.gentoo.org/proj/en/portage/tools/index.xml) with my fix of [bug #373219](https://bugs.gentoo.org/show_bug.cgi?id=373219)
 * [app-portage/ibashrc](https://github.com/init6/init_6/tree/master/app-portage/ibashrc) [Portage's intelligent bashrc](https://github.com/init6/ibashrc)
 * [app-portage/udept](https://github.com/init6/init_6/tree/master/app-portage/udept) [Udept is a collection of Portage scripts, maintenance tools and analysis tools, written in bash and powered by the dep engine](https://github.com/init6/udept)
 * [dev-lang/julia](https://github.com/init6/init_6/tree/master/dev-lang/julia) [High-level, high-performance dynamic programming language for technical computing](http://julialang.org/)
 * [dev-libs/double-conversion](https://github.com/init6/init_6/tree/master/dev-libs/double-conversion) [Binary-decimal and decimal-binary routines forIEEE doubles](http://code.google.com/p/double-conversion/)
 * [dev-libs/libgcrypt](https://github.com/init6/init_6/tree/master/dev-libs/libgcrypt) [General purpose crypto library based on the code used in GnuPG](http://www.gnupg.org/)
 * [dev-libs/libgpg-error](https://github.com/init6/init_6/tree/master/dev-libs/libgpg-error) [Contains error handling functions used by GnuPG software](http://www.gnupg.org/related_software/libgpg-error)
 * [dev-libs/shflags](https://github.com/init6/init_6/tree/master/dev-libs/shflags) [Simplified handling of command-line flags in Bourne based shells](http://code.google.com/p/shflags/)
 * [dev-libs/utf8proc](https://github.com/init6/init_6/tree/master/dev-libs/utf8proc) [library for processing UTF-8 encoded Unicode strings](http://www.public-software-group.org/utf8proc)
 * [dev-util/android-tools](https://github.com/init6/init_6/tree/master/dev-util/android-tools) [Android platform tools (adb and fastboot)](https://android.googlesource.com/platform/system/core.git/)
 * [dev-vcs/git-flow-completion](https://github.com/init6/init_6/tree/master/dev-vcs/git-flow-completion) [git flow completion for bash and zsh](https://github.com/bobthecow/git-flow-completion)
 * [dev-vcs/gitflow](https://github.com/init6/init_6/tree/master/dev-vcs/gitflow) [Git extensions supporting an advanced branching model](https://github.com/nvie/gitflow) fix for [bug #419943](https://bugs.gentoo.org/show_bug.cgi?id=419943)
 * [dev-vcs/gitlab-shell](https://github.com/init6/init_6/tree/master/dev-vcs/gitlab-shell) [GitLab Shell is a free SSH access and repository management application](https://github.com/gitlabhq/gitlab-shell)
 * [games-arcade/rocksndiamonds](https://github.com/init6/init_6/tree/master/games-arcade/rocksndiamonds) [A Boulderdash clone](http://www.artsoft.org/rocksndiamonds/)
 * [games-engines/openjk](https://github.com/init6/init_6/tree/master/games-engines/openjk) [Open Source Jedi Academy and Jedi Outcast games engine](https://github.com/JACoders/OpenJK)
 * [games-fps/quake2-groundzero-data](https://github.com/init6/init_6/tree/master/games-fps/quake2-groundzero-data) [Quake 2: Ground Zero data files](http://www.roguesoftware.com/)
 * [games-fps/quake2-reckoning-data](https://github.com/init6/init_6/tree/master/games-fps/quake2-reckoning-data) [Quake 2: The Reckoning data files](http://www.gmistudios.com/)
 * [games-fps/yamagi-quake2](https://github.com/init6/init_6/tree/master/games-fps/yamagi-quake2) [An enhanced client for id Software's Quake II with full 64-bit support](https://github.com/yquake2/yquake2)
 * [games-fps/yamagi-quake2-ctf](https://github.com/init6/init_6/tree/master/games-fps/yamagi-quake2-ctf) [Three Wave Caputure The Flag](https://github.com/yquake2/yquake2)
 * [games-fps/yamagi-quake2-rogue](https://github.com/init6/init_6/tree/master/games-fps/yamagi-quake2-rogue) [Quake II Mission Pack 2 - Ground Zero](https://github.com/yquake2/yquake2)
 * [games-fps/yamagi-quake2-xatrix](https://github.com/init6/init_6/tree/master/games-fps/yamagi-quake2-xatrix) [Quake II Mission Pack 1 - The Reckoning](https://github.com/yquake2/yquake2)
 * [media-fonts/iso_latin_1](https://github.com/init6/init_6/tree/master/media-fonts/iso_latin_1) [iso-latin-1 based linux console font](https://github.com/init6/iso-latin-1)
 * [net-wireless/broadcom-sta](https://github.com/init6/init_6/tree/master/net-wireless/broadcom-sta) [Broadcom's IEEE 802.11a/b/g/n hybrid Linux device drive](http://www.broadcom.com/support/802.11/linux_sta.php) with fix for [bug #484676](https://bugs.gentoo.org/show_bug.cgi?id=484676)
 * [sci-libs/openlibm](https://github.com/init6/init_6/tree/master/sci-libs/openlibm) [High quality system independent, open source libm](http://julialang.org/)
 * [sys-apps/kmscon](https://github.com/init6/init_6/tree/master/sys-apps/kmscon) [KMS/DRM based virtual Console Emulator](http://www.freedesktop.org/wiki/Software/kmscon)
 * [sys-apps/squashed-portage](https://github.com/init6/init_6/tree/master/sys-apps/squashed-portage) [squashed-portage](https://github.com/init6/squashed-portage) by the old wiki [squashed portage tree](http://web.archive.org/web/20130412155603/http://en.gentoo-wiki.com/wiki/Squashed_Portage_Tree) or [mirror](https://github.com/init6/init_6/wiki/squashed-portage-tree). [project wiki](https://github.com/init6/init_6/wiki/squashed-portage-tree)
 * [sys-apps/util-linux](https://github.com/init6/init_6/tree/master/sys-apps/util-linux) [Various useful Linux utilities](http://www.kernel.org/pub/linux/utils/util-linux/)
 * [sys-devel/binutils-config](https://github.com/init6/init_6/tree/master/sys-devel/binutils-config) [Utility to change the binutils version being used](http://www.gentoo.org/) with my fix of [bug #373219](https://bugs.gentoo.org/show_bug.cgi?id=373219)
 * [sys-devel/binutils-linaro](https://github.com/init6/init_6/tree/master/sys-devel/binutils-linaro) [Tools necessary to build programs](https://www.gnu.org/software/binutils) with [Linaro](http://www.linaro.org) patches
 * [sys-devel/gcc-config](https://github.com/init6/init_6/tree/master/sys-devel/gcc-config) [utility to manage compilers](http://git.overlays.gentoo.org/gitweb/?p=proj/gcc-config.git) with my fix of [bug #373219](https://bugs.gentoo.org/show_bug.cgi?id=373219)
 * [sys-devel/gcc-linaro](https://github.com/init6/init_6/tree/master/sys-devel/gcc-linaro) [The GNU Compiler Collection](https://gcc.gnu.org) with [Linaro](http://www.linaro.org) patches
 * [sys-devel/gdb-linaro](https://github.com/init6/init_6/tree/master/sys-devel/gdb-linaro) [GNU debugger](https://www.gnu.org/software/gdb) with [Linaro](http://www.linaro.org) patches
 * [sys-devel/ipatch](https://github.com/init6/init_6/tree/master/sys-apps/util-linux) [Intelligent patch wrapper](https://github.com/init6/ipatch)
 * [sys-firmware/intel-ucode](https://github.com/init6/init_6/tree/master/sys-firmware/intel-ucode) [Intel IA32 microcode update data](http://downloadcenter.intel.com/SearchResult.aspx?lang=eng&keyword=%22microcode%22)
 * [sys-firmware/nouveau-firmware](https://github.com/init6/init_6/tree/master/sys-firmware/nouveau-firmware) [Kernel and mesa firmware for nouveau (video accel and pgraph)](http://nouveau.freedesktop.org/wiki/VideoAcceleration/) my fix for [bug #480832](https://bugs.gentoo.org/show_bug.cgi?id=480832)
 * [sys-kernel/geek-sources](https://github.com/init6/init_6/tree/master/sys-kernel/geek-sources) [Full geek`s kernel linux sources including](https://github.com/init6/init_6/wiki/geek-sources):
     * **aufs** - [Another Union FS](http://aufs.sourceforge.net)
     * **bfq** - [Budget Fair Queueing Budget I/O Scheduler](http://algo.ing.unimo.it/people/paolo/disk_sched/sources.php)
     * **bld** - [Alternate CPU load distribution technique for Linux kernel scheduler](http://code.google.com/p/bld)
     * **brand** - [Enable Gentoo specific branding.](https://github.com/init6/init_6/wiki/geek-sources)
     * **cjktty** - [CJK support for tty framebuffer vt](https://github.com/Gentoo-zh/linux-cjktty)
     * **ck** - [Enable Con Kolivas' high performance patchset](http://users.on.net/~ckolivas/kernel)
     * **deblob** - [Remove binary blobs from kernel sources to provide libre license compliance](http://linux-libre.fsfla.org/pub/linux-libre)
     * **exfat** - [Samsung’s exFAT fs Linux driver](http://opensource.samsung.com/reception/receptionSub.do?method=search&searchValue=exfat)
     * **fedora** - [Use Fedora kernel patches](http://pkgs.fedoraproject.org/cgit/kernel.git)
     * **gentoo** - [Use Gentoo kernel patches](http://dev.gentoo.org/~mpagano/genpatches)
     * **grsec** - [Use hardened-patchset](http://git.overlays.gentoo.org/gitweb/?p=proj/hardened-patchset.git;a=summary) which includes a [grsecurity patches](http://grsecurity.net)
     * **ice** - [Use TuxOnIce patches](https://github.com/NigelCunningham/tuxonice-kernel)
     * **lqx** - [Use liquorix patches](http://liquorix.net)
     * **mageia** - [Use Mageia patches](http://svnweb.mageia.org/packages/cauldron/kernel)
     * **openelec** - [Use OpenELEC patches](http://openelec.tv)
     * **openvz** - [RHEL6 kernel with OpenVZ patchset](http://openvz.org)
     * **openwrt** - [OpenWrt kernel patches](https://openwrt.org)
     * **optimize** - [Kernel patch enables gcc optimizations for additional CPUs](https://github.com/graysky2/kernel_gcc_patch)
     * **pax** - [Use PAX patches](http://pax.grsecurity.net)
     * **pf** - [Use pf-kernel patches](http://pf.natalenko.name)
     * **reiser4** - [Use Reiser4 FS patches](http://sourceforge.net/projects/reiser4)
     * **rh** - [Use Red Hat Enterprise Linux kernel patches or sources](http://www.redhat.com)
     * **rsbac** - [RSBAC (Rule Set Based Access Control) patches](http://www.rsbac.org)
     * **rt** - [Use Ingo Molnar's realtime preempt patches](http://www.kernel.org/pub/linux/kernel/projects/rt)
     * **suse** - [Use OpenSuSE patches](http://kernel.opensuse.org/cgit/kernel-source)
     * **uek** - [Use Oracle’s Unbreakable Enterprise Linux Kernel sources](https://linux.oracle.com/pls/apex/f?p=101:3)
     * **uksm** - [Use Ultra Kernel Samepage Merging patches](http://kerneldedup.org)
     * **zen** - [Use ZEN kernel patches](https://github.com/damentz/zen-kernel)
     * **zfs** - [The native Linux kernel port of the ZFS filesystem](http://zfsonlinux.org)
 * [sys-kernel/rh-sources](https://github.com/init6/init_6/tree/master/sys-kernel/rh-sources) [Full sources including the Red Hat Enterprise Linux sources patchset for the 2.6 kernel tree](http://www.redhat.com/)
 * [sys-kernel/vanilla-sources](https://github.com/init6/init_6/tree/master/sys-kernel/vanilla-sources) [Full sources for the Linux kernel](http://www.kernel.org)
 * [sys-libs/core-functions](https://github.com/init6/init_6/tree/master/sys-libs/core-functions) [provide alternative for /etc/init.d/functions.sh](https://github.com/init6/core-functions) my fix for [bug #373219](https://bugs.gentoo.org/show_bug.cgi?id=373219)
 * [sys-libs/libtsm](https://github.com/init6/init_6/tree/master/sys-libs/libtsm) [A state machine for DEC VT100-VT520 compatible terminal emulators](http://www.freedesktop.org/wiki/Software/kmscon)
 * [www-apps/gitlabhq](https://github.com/init6/init_6/tree/master/www-apps/gitlabhq) [GitLab is a free project and repository management application](https://github.com/gitlabhq/gitlabhq)
 * [x11-misc/urxvt-vtwheel](https://github.com/init6/init_6/tree/master/x11-misc/urxvt-vtwheel) [Scroll wheel support for urxvt](https://aur.archlinux.org/packages/urxvt-vtwheel/)
 * [x11-terms/rxvt-unicode](https://github.com/init6/init_6/tree/master/x11-terms/rxvt-unicode) [rxvt clone with xft and unicode support](http://software.schmorp.de/pkg/rxvt-unicode.html)

and many fixes and patches…

Dynamic sets:
-------------

	@init6-rebuild	= rebuilds all installed packages from this overlay.
			nice for rebuilding, as it will rebuild also
			all dependencies (simple rerun of emerge on some static set will not)

	@init6-all	= all ebuilds from overlay, excluding those listed
			into @init6-broken (see below). Still
			broken ebuild might be fetched as
			dependencies. Use it, if you want to install
			and try all known packages from overlay.

Static sets:
-------------

	Meta sets:
	----------

	@arx		= Arx libertatis stuff
	@chromium	= Chromium stuff
	@core		= Only stage3 core stuff
	@e17		= enlightenment 17 stuff
	@gnome		= Gnome set
	@kernel		= Only kernel. Read [Depclean Tricks sets.conf](http://www.gentoo-pr.org/node/18)
	@portage	= Portage stuff set
	@toolchain	= Only toolchain
	@wireless	= wireless stuff set
	@X		= X stuff set
	@kde-4.13	= Custom Kde set

	Kde sub sets:
	----------

	@kdeadmin-4.13
	@kdeartwork-4.13
	@kdebase-4.13
	@kde-baseapps-4.13
	@kdebase-runtime-4.13
	@kdebase-workspace-4.13
	@kdegraphics-4.13
	@kdelibs-4.13
	@kdemultimedia-4.13
	@kdenetwork-4.13
	@kdepim-4.13
	@kdeutils-4.13

Developer sets:
---------------

	@init6-broken	= List of programs known to be broken for a long time
			Used by @init6-all script for
			excluding and filtering them out

Contribute to this overlay
--------------------------

Contributions are welcome. Fork (preferably to a branch) and create a pull request. If you find Bug open new [issue](https://github.com/init6/init_6/issues)

Contributors
--------------------------
Right to access directly to the overlay at the moment have: [CarelessChaser](https://github.com/CarelessChaser), [deterok](https://github.com/deterok), [grondinm](https://github.com/grondinm), [init_6](https://github.com/init6), [nilekurt](https://github.com/nilekurt), [Pinkbyte](https://github.com/Pinkbyte), [tazhate](https://github.com/tazhate), [Yamakuzure](https://github.com/Yamakuzure).

Release security & signing
--------------------------

All release media will have its Manifest file signed by one of the keys listed on this page.

| Key ID | Key Type | Key Fingerprint | Key Description | Created | Expires | Revoked | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| B9489F0C | 2048-bit DSA/ElGamal | E10F 898F F87E 82A6 928E EC6E 4DFA 96F5 B948 9F0C | Andrey Ovcharov (init_6) <sudormrfhalt@gmail.com> | 2013-08-13 | 2014-02-09 | | Revoked for changeover |
| 42E8AE40 | 2048-bit DSA/ElGamal | 3810 BDF2 9D0A 13E4 C8A1 805F 0DBF 6EF3 42E8 AE40 | Andrey Ovcharov (init_6) <sudormrfhalt@gmail.com> | 2014-02-09 | 2015-02-09 | | Key is lost |

You will find more in the [GnuPG Gentoo User Guide](http://www.gentoo.org/doc/en/gnupg-user.xml)
