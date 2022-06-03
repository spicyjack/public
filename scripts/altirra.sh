#!/bin/bash

# run Altirra under WINE
ALTIRRA_PATH="/Users/brian/Working/Altirra/Altirra-4.01"
/usr/local/bin/wine64 ${ALTIRRA_PATH}/Altirra64.exe \
   2> ${ALTIRRA_PATH}/Altirra64.wine.log
