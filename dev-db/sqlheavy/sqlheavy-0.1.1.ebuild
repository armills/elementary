# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_MAX_API_VERSION=0.16

inherit vala autotools-utils

DESCRIPTION="GObject SQLite wrapper"
HOMEPAGE="http://code.google.com/p/sqlheavy/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0.1"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	>=dev-db/sqlite-3.6.20:3
	>=dev-libs/glib-2.22:2
	>=x11-libs/gtk+-2.24:2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

AUTOTOOLS_IN_SOURCE_BUILD=1

pkg_setup() {
	DOCS=(AUTHORS COPYING ChangeLog NEWS README)
}

src_prepare() {
	autotools-utils_src_prepare
	vala_src_prepare
}

src_compile() {
	autotools-utils_src_compile -j1
}

src_install() {
	autotools-utils_src_install

	# Create a slotted version of the binary
	mv "${ED}/usr/bin/sqlheavy-gen-orm" "${ED}/usr/bin/sqlheavy-gen-orm-${SLOT}"
	mv "${ED}/usr/share/man/man1/sqlheavy-gen-orm.1" "${ED}/usr/share/man/man1/sqlheavy-gen-orm-${SLOT}.1"
}
