EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop pax-utils multilib-build unpacker

DESCRIPTION="Google Cloud SDK"
HOMEPAGE="https://cloud.google.com/sdk"

# https://cloud.google.com/sdk/docs/install
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${PN}-${PV}-linux-x86_64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="dev-lang/python[${MULTILIB_USEDEP}]"
QA_PREBUILT="*"
S="${WORKDIR}"

src_install() {
	dodir /opt
	cp -a google-cloud-sdk "${ED}"/opt || die

	dodir /usr/bin
	dosym /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
	dosym /opt/google-cloud-sdk/bin/gsutil /usr/bin/gsutil
}
