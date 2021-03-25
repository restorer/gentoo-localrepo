EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop pax-utils multilib-build unpacker

DESCRIPTION="The Desktop API client for REST, GraphQL and gRPC. Make requests, inspect responses."
HOMEPAGE="https://insomnia.rest/"
SRC_URI="https://github.com/httptoolkit/httptoolkit-desktop/releases/download/v1.2.1/HttpToolkit-${PV}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

QA_PREBUILT="*"
S="${WORKDIR}"

src_unpack() {
	default
	unpack "${WORKDIR}/data.tar.xz"
	unpack "${WORKDIR}/usr/share/doc/httptoolkit/changelog.gz"
}

src_install() {
	dodir /opt
	cp -a opt/"HTTP Toolkit" "${ED}"/opt || die

	dodir /usr/share
	cp -a usr/share/icons "${ED}"/usr/share/icons || die

	domenu usr/share/applications/httptoolkit.desktop
	dodoc changelog
}
