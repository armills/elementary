# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit gnome2-utils vala cmake-utils bzr

DESCRIPTION="A lightweight ToDo app written in Vala for the elementary project"
HOMEPAGE="https://launchpad.net/ergo"
EBZR_REPO_URI="lp:ergo"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/granite"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING COPYRIGHT )
}

src_prepare() {
	epatch "${FILESDIR}/fix-983560.patch"

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
