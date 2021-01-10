EAPI=7

inherit eutils cmake

DESCRIPTION="TIC-80 is a FREE and OPEN SOURCE fantasy computer for making, playing and sharing tiny games"
HOMEPAGE="https://tic80.com/"

SRC_URI="
	https://github.com/nesbox/TIC-80/archive/0dc0ea01088441af7f63b5997137624e182778ca.tar.gz -> ${PN}.tar.gz
	https://github.com/nesbox/blip-buf/archive/de703256519288fea7d0c403559f9ab19490cf34.tar.gz -> ${PN}-blip-buf.tar.gz
	https://github.com/nesbox/curl/archive/f783460ffd582438936daf8c40ce2941a91f3a15.tar.gz -> ${PN}-curl.tar.gz
	https://github.com/tronkko/dirent/archive/c885633e126a3a949ec0497273ec13e2c03e862c.tar.gz -> ${PN}-dirent.tar.gz
	https://github.com/svaarala/duktape-releases/archive/5da6f2c83af31c1e242bbc77b163e1756b6ec2ed.tar.gz -> ${PN}-ducktape.tar.gz
	https://github.com/nesbox/giflib/archive/1aa11b06d0025eda77b56aec8254130654d4397b.tar.gz -> ${PN}-giflib.tar.gz
	https://github.com/nesbox/lpeg/archive/73d8614a8dea404cf7bfe25a6e4cea7183dc9fb7.tar.gz -> ${PN}-lpeg.tar.gz
	https://github.com/lua/lua/archive/89aee84cbc9224f638f3b7951b306d2ee8ecb71e.tar.gz -> ${PN}-lua.tar.gz
	https://github.com/grimfang4/sdl-gpu/archive/e3d350b325a0e0d0b3007f69ede62313df46c6ef.tar.gz -> ${PN}-sdl-gpu.tar.gz
	https://github.com/SDL-mirror/SDL/archive/76468465a94b59f0dde4791846bc2476be4f245f.tar.gz -> ${PN}-sdl2.tar.gz
	https://github.com/floooh/sokol/archive/487822d82ca79dba7b67718d962e1ba6beef01b2.tar.gz -> ${PN}-sokol.tar.gz
	https://github.com/albertodemichelis/squirrel/archive/9dcf74f99097898dd5a111c4a55b89d1c4d606c0.tar.gz -> ${PN}-squirrel.tar.gz
	https://github.com/wren-lang/wren/archive/cd012469976d1a9da796581cd9a9591842cb0cf8.tar.gz -> ${PN}-wren.tar.gz
	https://github.com/kuba--/zip/archive/f053be982fe76237db595d5b049b3a36c7b97997.tar.gz -> ${PN}-zip.tar.gz
	https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.tar.gz -> ${PN}-zlib.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	x11-libs/gtk+:3
	dev-util/cmake
	media-libs/libglvnd
	media-libs/mesa
	media-libs/glu
	media-libs/freeglut
"

src_unpack () {
	default
	mv TIC-80-0dc0ea01088441af7f63b5997137624e182778ca "${S}" || die
}

src_prepare () {
	default

	rmdir vendor/blip-buf || die
	mv ../blip-buf-de703256519288fea7d0c403559f9ab19490cf34 vendor/blip-buf || die

	rmdir vendor/curl || die
	mv ../curl-f783460ffd582438936daf8c40ce2941a91f3a15 vendor/curl || die

	rmdir vendor/dirent || die
	mv ../dirent-c885633e126a3a949ec0497273ec13e2c03e862c vendor/dirent || die

	rmdir vendor/duktape || die
	mv ../duktape-releases-5da6f2c83af31c1e242bbc77b163e1756b6ec2ed vendor/duktape || die

	rmdir vendor/giflib || die
	mv ../giflib-1aa11b06d0025eda77b56aec8254130654d4397b vendor/giflib || die

	rmdir vendor/lpeg || die
	mv ../lpeg-73d8614a8dea404cf7bfe25a6e4cea7183dc9fb7 vendor/lpeg || die

	rmdir vendor/lua || die
	mv ../lua-89aee84cbc9224f638f3b7951b306d2ee8ecb71e vendor/lua || die

	rmdir vendor/sdl-gpu || die
	mv ../sdl-gpu-e3d350b325a0e0d0b3007f69ede62313df46c6ef vendor/sdl-gpu || die

	rmdir vendor/sdl2 || die
	mv ../SDL-76468465a94b59f0dde4791846bc2476be4f245f vendor/sdl2 || die

	rmdir vendor/sokol || die
	mv ../sokol-487822d82ca79dba7b67718d962e1ba6beef01b2 vendor/sokol || die

	rmdir vendor/squirrel || die
	mv ../squirrel-9dcf74f99097898dd5a111c4a55b89d1c4d606c0 vendor/squirrel || die

	rmdir vendor/wren || die
	mv ../wren-cd012469976d1a9da796581cd9a9591842cb0cf8 vendor/wren || die

	rmdir vendor/zip || die
	mv ../zip-f053be982fe76237db595d5b049b3a36c7b97997 vendor/zip || die

	rmdir vendor/zlib || die
	mv ../zlib-cacf7f1d4e3d44d871b605da3b647f07d718623f vendor/zlib || die

	cmake_src_prepare
}

src_configure () {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_PRO=ON
		-DBUILD_SHARED_LIBS=OFF
	)

	cmake_src_configure
}
