#!/bin/bash
set -o errexit -o pipefail -o nounset

mypath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

orig=chromium

mv /usr/bin/${orig} /usr/bin/chromium-browser.original
cp ${mypath}/chromium-browser /usr/bin/${orig}
chmod +x /usr/bin/${orig}
cp /usr/bin/${orig} /usr/bin/${orig}--no-sandbox
