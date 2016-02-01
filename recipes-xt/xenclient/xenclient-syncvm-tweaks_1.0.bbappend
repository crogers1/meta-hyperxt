# Replace db-tools with qtdbd tools.
# TODO: Make qtdbd optional
python () {
    import string

    rdeps = bb.data.getVar("RDEPENDS", d)
    rdeps = string.replace(rdeps, 'db-tools', 'qtdbd-tools qtdbd-tools-v4v-wrappers')   
    bb.data.setVar("RDEPENDS", rdeps, d)
}

PRINC := "${@int(PRINC) + 1}"


