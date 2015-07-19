# $Header: $

EAPI="5"

inherit eutils git-2 autotools

DESCRIPTION="Shairport Sync emulates an AirPort Express for the purpose of streaming audio from iTunes, iPods, iPhones, iPads and AppleTVs. Audio played by a Shairport Sync-powered device stays synchronised with the source and hence with similar devices playing the same source. Thus, for example, synchronised multi-room audio is possible without difficulty. (Hence the name Shairport Sync, BTW.)"

HOMEPAGE="https://github.com/mikebrady/shairport-sync"
EGIT_REPO_URI="https://github.com/mikebrady/shairport-sync.git"

SLOT="0"
KEYWORDS=""
IUSE="ao avahi pulseaudio"

DEPEND="dev-libs/openssl \
	media-libs/alsa-lib \
	dev-libs/libdaemon \
	dev-libs/popt \
	media-libs/soxr \
	sys-auth/nss-mdns \
	net-dns/avahi[dbus]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/rm-default-init.patch"
	eautoreconf
}

src_configure() {
    econf --with-alsa \
	  $(use_with avahi ) \
          --with-ssl=openssl \
          --with-soxr
}

src_install() {
	emake DESTDIR="${D}" install

	doinitd "${FILESDIR}/init.d/shairport-sync"
	doconfd "${FILESDIR}/conf.d/shairport-sync"
}
