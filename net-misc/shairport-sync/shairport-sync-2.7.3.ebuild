# $Header: $

EAPI="5"

inherit eutils autotools

DESCRIPTION="Shairport Sync emulates an AirPort Express for the purpose of streaming audio from iTunes, iPods, iPhones, iPads and AppleTVs. Audio played by a Shairport Sync-powered device stays synchronised with the source and hence with similar devices playing the same source. Thus, for example, synchronised multi-room audio is possible without difficulty. (Hence the name Shairport Sync, BTW.)"

HOMEPAGE="https://github.com/mikebrady/shairport-sync"
SRC_URI="https://github.com/mikebrady/shairport-sync/archive/${PV}.tar.gz"

SLOT="0"
KEYWORDS="~arm"
IUSE="ao avahi pulseaudio"

DEPEND="dev-libs/openssl \
	media-libs/alsa-lib \
	dev-libs/libdaemon \
	dev-libs/popt \
	media-libs/soxr \
	sys-auth/nss-mdns \
	net-dns/avahi[dbus]"
RDEPEND="${DEPEND}"

src_configure() {
    econf --with-alsa \
	  $(use_with avahi ) \
          --with-ssl=openssl \
          --with-soxr
}