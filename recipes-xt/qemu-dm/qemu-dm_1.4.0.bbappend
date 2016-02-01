python () {
	import string

	rdeps = bb.data.getVar("SRC_URI", d)
	rdeps = string.replace(rdeps, 'file://xsa-131-unmediated-pci-register-access-in-qemu.patch;patch=1', '')
	bb.data.setVar("SRC_URI", rdeps, d)

}
