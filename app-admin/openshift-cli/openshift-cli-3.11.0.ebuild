EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop pax-utils multilib-build unpacker

DESCRIPTION="OpenShift CLI"
HOMEPAGE="https://www.okd.io/"
SRC_URI="https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

QA_PREBUILT="*"
S="${WORKDIR}"

src_prepare() {
	default
	mv openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/* .
	mv kubectl kubectl-oc
}

src_install() {
	dobin oc
	dobin kubectl-oc
	dodoc README.md
}

pkg_postinst() {
	elog "'kubectl' is installed as 'kubectl-oc' to avoid clashing with sys-cluster/kubectl"
}
