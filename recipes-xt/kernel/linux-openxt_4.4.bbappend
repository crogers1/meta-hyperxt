include linux-appends.inc

do_configure_prepend_xenclient-dom0(){
  #Enable the USB network cards for 2-in-1's.
  enable_kernel_module "CONFIG_USB_NET_AX8817X"
  enable_kernel_module "CONFIG_USB_NET_AX88179_178A"
}

PRINC := "${@int(PRINC) + 1}"
