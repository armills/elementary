# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils

DESCRIPTION="The Date and Time Indicator - A very, very simple clock"
HOMEPAGE="https://launchpad.net/indicator-datetime"
SRC_URI="http://launchpad.net/${PN}/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	app-misc/geoclue
	dev-libs/glib:2
	>=dev-libs/libdbusmenu-0.5.90:3[gtk]
	dev-libs/libical
	dev-libs/libindicator:3
	gnome-base/gconf
	>=gnome-extra/evolution-data-server-3
	<gnome-extra/evolution-data-server-3.5
	x11-libs/cairo
	>=x11-libs/gtk+-3.1.4:3
	x11-libs/libido:3"
DEPEND="${RDEPEND}"

src_prepare() {
	# Drop -Werror flag
	sed -i -e 's/-Werror//' src/Makefile.in
}

src_install() {
	prune_libtool_files --all

	autotools-utils_src_install
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
