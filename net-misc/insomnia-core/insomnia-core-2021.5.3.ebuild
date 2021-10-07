EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop pax-utils multilib-build unpacker

DESCRIPTION="The Desktop API client for REST, GraphQL and gRPC. Make requests, inspect responses."
HOMEPAGE="https://insomnia.rest/"
SRC_URI="https://github.com/Kong/insomnia/releases/download/core%40${PV}/Insomnia.Core-${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

QA_PREBUILT="*"
S="${WORKDIR}"

src_unpack() {
	default
	unpack "${WORKDIR}/data.tar.xz"
	unpack "${WORKDIR}/usr/share/doc/insomnia/changelog.gz"
}

src_install() {
	dodir /opt
	cp -a opt/Insomnia "${ED}"/opt || die

	dodir /usr/share
	cp -a usr/share/icons "${ED}"/usr/share/icons || die

	domenu usr/share/applications/insomnia.desktop
	dodoc changelog
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
