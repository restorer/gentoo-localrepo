EAPI=7

MULTILIB_COMPAT=( abi_x86_64 )

inherit desktop pax-utils multilib-build unpacker

DESCRIPTION="Double Commander (portable package)"
HOMEPAGE="https://doublecmd.sourceforge.io/"
SRC_URI="mirror://sourceforge/doublecmd/doublecmd-${PV}.gtk2.x86_64.tar.xz"

# QT5 version has bugs (can't change font, visual glitches), so GTK2 version is used instead.
## SRC_URI="mirror://sourceforge/doublecmd/doublecmd-${PV}.qt5.x86_64.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

# >=dev-qt/qtcore-5.6[${MULTILIB_USEDEP}]
RDEPEND="
	sys-apps/dbus[${MULTILIB_USEDEP}]
	dev-libs/glib[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/gtk+:2[${MULTILIB_USEDEP}]
"

QA_PREBUILT="*"
S="${WORKDIR}"

src_prepare() {
	default

	# Enable configuration in user home directory
	rm doublecmd/doublecmd.inf || die

	sed -i -e 's@./doublecmd@exec ./doublecmd@' doublecmd/doublecmd.sh
}

src_install() {
	dodir /opt
	cp -a doublecmd "${ED}"/opt || die
}
