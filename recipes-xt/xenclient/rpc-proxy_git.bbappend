# Add qtdbd-specific patch.
# TODO: Make qtdbd optional

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += " file://add-db-dump.manualpatch"

do_install_append() {
    pushd ${D}; patch -p1 < ${WORKDIR}/add-db-dump.manualpatch; popd
}

PRINC := "${@int(PRINC) + 1}"
