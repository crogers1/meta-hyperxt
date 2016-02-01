# Replace db-tools with qtdbd tools.
# TODO: Make qtdbd optional

python () {
    import string

    rdeps = bb.data.getVar("RDEPENDS_xenclient-ndvm", d)
    rdeps = string.replace(rdeps, 'db-tools', 'qtdbd-tools qtdbd-tools-v4v-wrappers')   
    bb.data.setVar("RDEPENDS_xenclient-ndvm", rdeps, d)
}

PRINC := "${@int(PRINC) + 1}"


