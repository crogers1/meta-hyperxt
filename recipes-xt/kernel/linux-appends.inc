#
# Simple functions to help with modification of kernel parameters.
#

enable_kernel_tristate() {
  sed -i "/${1}/d" ${WORKDIR}/defconfig
  echo "${1}=${2}" >> ${WORKDIR}/defconfig
}

enable_kernel_option() {
  enable_kernel_tristate "${1}" "y"
}

enable_kernel_module() {
  enable_kernel_tristate "${1}" "m"
}
