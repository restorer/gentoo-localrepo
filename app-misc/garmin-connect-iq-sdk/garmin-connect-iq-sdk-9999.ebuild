EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop pax-utils multilib-build unpacker

DESCRIPTION="Garmin Connect IQ SDK"
HOMEPAGE="https://developer.garmin.com/connect-iq/sdk/"
SRC_URI="https://developer.garmin.com/downloads/connect-iq/sdk-manager/connectiq-sdk-manager-linux.zip"

LICENSE="garmin"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="
	net-libs/webkit1-gtk[${MULTILIB_USEDEP}]
	media-libs/libjpeg-turbo[${MULTILIB_USEDEP}]
"

QA_PREBUILT="*"
S="${WORKDIR}"

src_install() {
	dodir /opt/garmin-connect-iq-sdk
	cp -a bin "${ED}"/opt/garmin-connect-iq-sdk || die
	cp -a share "${ED}"/opt/garmin-connect-iq-sdk || die

	dodir /usr/bin

	echo '#!/bin/sh
exec /opt/garmin-connect-iq-sdk/bin/sdkmanager' > "${ED}"/usr/bin/sdkmanager-garmin || die

	chmod a+x "${ED}"/usr/bin/sdkmanager-garmin || die

	dodir /usr/lib64
	ln -s -T libjpeg.so "${ED}"/usr/lib64/libjpeg.so.8
}

pkg_postinst() {
	elog "To complete the installation, see https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/"
}
