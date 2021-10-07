# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="Inno Setup installer package extractor (Windows executable)"
HOMEPAGE="http://innounp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV//.}.rar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (
	app-arch/unrar-gpl
	app-arch/unrar
	app-arch/rar )"

RDEPEND="virtual/wine"

src_install() {
	local DIR="/usr/$(get_libdir)/wine/fakedlls"

	insinto "${DIR}"
	doins "${PN}.exe" || die
	dodoc "${PN}.htm" || die

	make_wrapper "${PN}" "wine \"${DIR}/${PN}.exe\""
}
