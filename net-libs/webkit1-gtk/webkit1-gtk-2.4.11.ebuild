EAPI=7
USE_RUBY="ruby24 ruby25 ruby26 ruby27"

inherit eutils ruby-single autotools

DESCRIPTION="libwebkitgtk-1.0 for older binaries that link to it."
HOMEPAGE="https://packages.debian.org/stretch/libwebkitgtk-1.0-0"

SRC_URI="
	https://deb.debian.org/debian/pool/main/w/webkitgtk/webkitgtk_2.4.11.orig.tar.xz
	https://deb.debian.org/debian/pool/main/w/webkitgtk/webkitgtk_2.4.11-3.debian.tar.xz
"

LICENSE="LGPL-2+ BSD"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 ~sparc x86"

IUSE="+geolocation gtk-doc"

RDEPEND="
	sys-apps/gawk
	sys-devel/make
	dev-libs/glib
	x11-libs/gtk+:2
	x11-libs/pango
	media-libs/harfbuzz
	x11-libs/cairo
	media-libs/fontconfig
	media-libs/freetype
	dev-libs/icu
	dev-libs/libxslt
	dev-libs/libxml2
	net-libs/libsoup
	dev-db/sqlite
	dev-libs/libgudev
	sys-devel/flex
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libwebp
	x11-libs/libXt
	media-libs/gstreamer
	app-text/enchant
	app-crypt/libsecret
	dev-libs/gobject-introspection
	media-libs/mesa
	geolocation? ( app-misc/geoclue )
"

DEPEND="
	${RDEPEND}
	${RUBY_DEPS}
	dev-util/gperf
	sys-devel/bison
	gtk-doc? ( dev-util/gtk-doc )
"

S="${WORKDIR}/webkitgtk-2.4.11"
# ECONF_SOURCE="${S}"

src_prepare () {
	default
	_P="${WORKDIR}/debian/patches"

	eapply "${_P}/install-minibrowser.patch"
	eapply "${_P}/atomic_build_fix.patch"
	eapply "${_P}/restore_sparc_code.patch"
	eapply "${_P}/02_notebook_scroll.patch"
	eapply "${_P}/ftbfs-armhf.patch"
	eapply "${_P}/x32_support.patch"
	eapply "${_P}/disable-jit-nonsse2.patch"
	eapply "${_P}/fix-ftbfs-m68k.patch"
	eapply "${_P}/fix-ftbfs-gcc6.patch"

	_AM="$(ls /usr/bin | grep '^aclocal\-' | head -n 1 | sed 's@^aclocal-@@')" || die
	[ "${_AM}" = "" ] && die "aclocal is not found"

	sed -i "s/am__api_version='1.15'/am__api_version='${_AM}'/" configure || die
	sed -i '/unlink("$fileBase.hpp");/d' Source/WebCore/css/makegrammar.pl || die
	sed -i '/namespace WTF/i #include <wtf/unicode/UnicodeMacrosFromICU.h>' Source/WTF/wtf/text/WTFString.h || die

	sed -i '/static_assert/a \
#ifndef FALSE\
#define FALSE (0)\
#endif\
#ifndef TRUE\
#define TRUE (1)\
#endif' Source/WTF/wtf/unicode/Unicode.h || die

	sed -i 's/OpaqueJSString::create(chars, numChars)/OpaqueJSString::create((const UChar*)chars, numChars)/' Source/JavaScriptCore/API/JSStringRef.cpp || die
	sed -i 's/createWithoutCopying(chars, numChars)/createWithoutCopying((const UChar*)chars, numChars)/' Source/JavaScriptCore/API/JSStringRef.cpp || die
	sed -i 's/string->characters()/(const JSChar*)(string->characters())/' Source/JavaScriptCore/API/JSStringRef.cpp || die
}

src_configure () {
	mkdir -p build-2.0
	cd build-2.0 || die

	# It doesn't compile when using econf, and I have no time to figure out why.
	../configure --disable-silent-rules \
		--enable-introspection \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/lib64" \
		--with-gtk=2.0 \
		--disable-webkit2 \
		$(use_enable geolocation) \
		$(use_enable gtk-doc)
}

src_compile () {
	emake -C build-2.0
}

src_install () {
	emake DESTDIR="${D}" -C build-2.0 install
	find "${D}" -name '*.la' -delete || die
}
