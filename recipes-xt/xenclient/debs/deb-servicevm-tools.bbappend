# Replace db-tools with qtdbd tools.
# TODO: Make qtdbd optional
python () {
    import string

    rdeps = bb.data.getVar("DEB_PACKAGES", d)
    rdeps = string.replace(rdeps, 'db-tools', 'qtdbd-tools qtdbd-tools-v4v-wrappers')   
    bb.data.setVar("DEB_PACKAGES", rdeps, d)
}

PRINC := "${@int(PRINC) + 1}"

