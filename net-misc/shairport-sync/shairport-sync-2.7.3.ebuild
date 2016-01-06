# $Header: $

EAPI="5"

inherit eutils autotools

DESCRIPTION="Shairport Sync emulates an AirPort Express for the purpose of streaming audio from iTunes, iPods, iPhones, iPads and AppleTVs. Audio played by a Shairport Sync-powered device stays synchronised with the source and hence with similar devices playing the same source. Thus, for example, synchronised multi-room audio is possible without difficulty. (Hence the name Shairport Sync, BTW.)"

HOMEPAGE="https://github.com/mikebrady/shairport-sync"
SRC_URI="https://github.com/mikebrady/shairport-sync/archive/${PV}.tar.gz"

SLOT="0"
KEYWORDS="~arm"
IUSE="avahi alsa +openrc systemd +openssl polarssl libsoxr"

DEPEND="openssl? ( dev-libs/openssl:= ) \
	polarssl? ( net-libs/polarssl ) \
	alsa? (	media-libs/alsa-lib:= ) \
	dev-libs/libdaemon \
	dev-libs/popt \
	libsoxr? ( media-libs/soxr ) \
	sys-auth/nss-mdns \
	net-dns/avahi[dbus]"
RDEPEND="${DEPEND}"

REQUIRED_USE=" ^^ ( openssl polarssl )"

src_prepare() {
	eautoreconf
}

src_configure() {
    econf $(use_with alsa) \
	  $(use_with avahi ) \
          --with-ssl=$(usex openssl openssl polarssl) \
          $(use_with libsoxr soxr) \
          --without-systemv \
          $(use_with systemd) \

#          --with-configfile
}

src_install() {
        emake DESTDIR="${D}" install

        doinitd "${FILESDIR}/init.d/shairport-sync"
}
