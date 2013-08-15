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

    emerge -av layman

and run

    layman -a init6

If you've never worked with a overlay, please read [Gentoo Overlays: Users' Guide](http://www.gentoo.org/proj/en/overlays/userguide.xml)

In this overlay you will find
-----------------------------
 * [app-emulation/wine](https://github.com/init6/init_6/tree/master/app-emulation/wine) with desktop and icon files and with with [with Maarten Lankhorst's multimedia patches, including PulseAudio support](http://repo.or.cz/w/wine/multimedia.git)
 * [app-misc/mc](https://github.com/init6/init_6/tree/master/app-misc/mc) with desktop and icon files
 * [net-irc/irssi](https://github.com/init6/init_6/tree/master/net-irc/irssi) with desktop and icon files
 * [sys-kernel/vanilla-sources](https://github.com/init6/init_6/blob/master/sys-kernel/vanilla-sources/vanilla-sources-9999.ebuild) live 9999 git ebuild
 * [sys-kernel/geek-sources](https://github.com/init6/init_6/tree/master/sys-kernel/geek-sources) [Full geek`s kernel linux sources including](https://github.com/init6/init_6/wiki/geek-sources):
     * **aufs** - [AnotherUnionFS](http://aufs.sourceforge.net)
     * **bfq** - [Budget Fair Queueing Budget I/O Scheduler](http://algo.ing.unimo.it/people/paolo/disk_sched/sources.php)
     * **bld** - [Alternate CPU load distribution technique for Linux kernel scheduler](http://code.google.com/p/bld)
     * **brand** - Enable Gentoo specific branding.
     * **ck** - [Enable Con Kolivas' high performance patchset](http://users.on.net/~ckolivas/kernel)
     * **deblob** - [Remove binary blobs from kernel sources to provide libre license compliance](http://linux-libre.fsfla.org/pub/linux-libre)
     * **fedora** - [Use Fedora kernel patches](http://pkgs.fedoraproject.org/cgit/kernel.git)
     * **gentoo** - [Use Gentoo kernel patches](http://dev.gentoo.org/~mpagano/genpatches)
     * **grsec** - [Use grsecurity patches](http://git.overlays.gentoo.org/gitweb/?p=proj/hardened-patchset.git;a=summary)
     * **ice** - [Use TuxOnIce patches](https://github.com/NigelCunningham/tuxonice-kernel)
     * **lqx** - [Use liquorix patches](http://liquorix.net)
     * **mageia** - [Use Mandriva/Mageia patches](http://svnweb.mageia.org/packages/cauldron/kernel)
     * **pax** - [Use PAX patches](http://pax.grsecurity.net)
     * **pf** - [Use pf-kernel patches](http://pf.natalenko.name)
     * **reiser4** - [Use Reiser4 FS patches](http://sourceforge.net/projects/reiser4)
     * **rt** - [Use Ingo Molnar's realtime preempt patches](http://www.kernel.org/pub/linux/kernel/projects/rt)
     * **suse** - [Use OpenSuSE patches](http://kernel.opensuse.org/cgit/kernel-source)
     * **uksm** - [Use Ultra Kernel Samepage Merging patches](http://kerneldedup.org)
     * **zen** - [Use ZEN kernel patches](https://github.com/damentz/zen-kernel)
     * **zfs** - [The native Linux kernel port of the ZFS filesystem](http://zfsonlinux.org)
 * [sys-kernel/rh-sources](https://github.com/init6/init_6/tree/master/sys-kernel/rh-sources) Full sources including the Red Hat Enterprise Linux sources patchset for the 2.6 kernel tree
and many fixes and patches…

Contribute to this overlay
--------------------------

If you want to suggest changes, like new dependencies or new stuff, please send a github pull request with explanation/proof why this is necessary, so we can discuss it. Determine correct behavior and dependencies can be tricky, therefore we'd like to discuss and wait for confirmation of others before adding modifications or new ebuilds.

Release security & signing
--------------------------

All release media will have its Manifest file signed by one of the keys listed on this page.

| Key ID        | Key Type                | Key Fingerprint                                   | Key Description                                   | Created    | Expires    | Revoked    | Notes      |
| ------------- |:-----------------------:| -------------------------------------------------:| -------------------------------------------------:| ----------:| ----------:| ----------:| ----------:|
| B9489F0C      |  2048-bit DSA / ElGamal | E10F 898F F87E 82A6 928E EC6E 4DFA 96F5 B948 9F0C | Andrey Ovcharov (init_6) <sudormrfhalt@gmail.com> | 2013-08-13 | 2014-02-09 |            |            |

You will find more in the [GnuPG Gentoo User Guide](http://www.gentoo.org/doc/en/gnupg-user.xml)