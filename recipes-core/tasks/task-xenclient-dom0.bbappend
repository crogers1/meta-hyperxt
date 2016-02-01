# Replace dbd with qtdbd.
# TODO: Make use of qtdbd optional
python () {
    import string

    rdeps = bb.data.getVar("RDEPENDS_task-xenclient-dom0", d)
    rdeps = string.replace(rdeps, 'dbd', 'qtdbd qtdbd-tools')   
    bb.data.setVar("RDEPENDS_task-xenclient-dom0", rdeps, d)
}

PRINC := "${@int(PRINC) + 1}"
