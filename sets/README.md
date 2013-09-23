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

	@core		= Only stage3 core stuff
	@gnome		= Gnome set
	@portage	= Portage stuff set
	@toolchain	= Only toolchain
	@wireless	= wireless stuff set
	@X		= X stuff set

Developer sets:
---------------

	@init6-broken	= List of programs known to be broken for a long time
			Used by @init6-all script for
			excluding and filtering them out
