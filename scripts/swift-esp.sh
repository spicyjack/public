#!/bin/bash

export SWIFT_EMBEDDED_DIR="${HOME}/Working/Swift_Embedded"
export TOOLCHAINS=org.swift.62202411201a
export IDF_TOOLS_PATH="${SWIFT_EMBEDDED_DIR}/espressif_tools/"
source ${SWIFT_EMBEDDED_DIR}/esp-idf.git/export.sh
idf.py set-target esp32c6
