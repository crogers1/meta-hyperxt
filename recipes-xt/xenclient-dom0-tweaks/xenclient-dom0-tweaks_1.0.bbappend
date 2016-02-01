#
# Ensure that the USB drivers have been packaged prior to our installation step.
#
do_install[depends] += "\
  virtual/kernel:do_package_write_ipk \
"

# Use our additional files.
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "\
  file://usb-network.conf \
  file://dom0_add_usb_networking.sh \
"

USB_DRIVER_KERNEL_MODULES = "asix usbnet mii libphy ax88179-178a"

#
# Install our rules that blacklist USB networking.
#
do_install_append() {

  # Ensure any added USB network drivers are always blacklisted.
	install -m 0644 ${WORKDIR}/usb-network.conf \
		${D}/etc/modprobe.d/usb-network.conf

  # Add our script that installs and enables USB networking in dom0.
	install -m 0755 ${WORKDIR}/dom0_add_usb_networking.sh \
		${D}/usr/share/xenclient/dom0_add_usb_networking.sh

  # Finally, copy all of the dom0 USB networking drivers into our package.
  # This allows them to be installed when necessary by the dom0_add_usb_networking
  # script.
  install -d ${D}/usr/share/xenclient/usb_network_drivers/
  for driver in ${USB_DRIVER_KERNEL_MODULES}; do
    cp ${DEPLOY_DIR_IPK}/${MACHINE_ARCH}/kernel-module-${driver}*.ipk ${D}/usr/share/xenclient/usb_network_drivers/
  done

}

PRINC := "${@int(PRINC) + 1}"
