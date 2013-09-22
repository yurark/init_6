#!/bin/sh

ROOT="$(portageq envvar ROOT)"
REPO_ROOT="$(portageq get_repo_path ${ROOT} init6)"

BROKEN="${REPO_ROOT}/sets/init6-broken"

for ebuild in $(find "${REPO_ROOT}" -name "*-9999.ebuild" | sed -r "s|^.*/([[:alnum:]_\.\-]+)/[^\/]+/([[:alnum:]_\.\-]+)-9999\.ebuild|\1/\2|"); do
	grep -q "${ebuild}" "${BROKEN}" && continue;

	test -f /etc/portage/init6.ignore &&
		grep -q "^${ebuild}$" /etc/portage/init6.ignore &&
		continue;

	echo ${ebuild};
done;
