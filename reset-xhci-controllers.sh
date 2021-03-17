#!/usr/bin/env bash

# Script to reset all local xHCI (USB) controllers
# Based on: <http://billauer.co.il/blog/2013/02/usb-reset-ehci-uhci-linux/>

if [[ ${EUID} != 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

for xhci in /sys/bus/pci/drivers/?hci_hcd; do
  if ! cd "${xhci}"; then
    echo "Failed to change directory to ${xhci}."
    exit 1
  fi

  echo "Resetting devices from ${xhci}..."
  for i in ????:??:??.?; do
    echo -n "${i}" > unbind
    echo -n "${i}" > bind
  done

done
