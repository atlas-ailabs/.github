#!/usr/bin/env bash
# Renders every image of the profile page into profile/assets, in the light and the dark theme.
# Needs a Chromium: CHROME=/path/to/chrome, Playwright's headless shell, or Google Chrome installed.
set -euo pipefail
cd "$(dirname "$0")"
OUT=../profile/assets

CHROME="${CHROME:-}"
if [[ -z "$CHROME" ]]; then
  # Playwright's headless shell first: it is what rendered the published images, pixel for pixel
  for c in "$(find "$HOME/Library/Caches/ms-playwright" "$HOME/.cache/ms-playwright" -name chrome-headless-shell -type f 2>/dev/null | head -1)" \
           "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
           "$(command -v chromium || true)" "$(command -v google-chrome || true)"; do
    [[ -n "$c" && -x "$c" ]] && CHROME="$c" && break
  done
fi
[[ -n "$CHROME" ]] || { echo "No Chromium found; set CHROME=/path/to/chrome" >&2; exit 1; }

# page, fragment (theme or theme-index), height, output name
render() {
  "$CHROME" --headless --hide-scrollbars --default-background-color=00000000 \
    --window-size=1280,"$3" --force-device-scale-factor=2 --virtual-time-budget=5000 \
    --screenshot="$OUT/$4.png" "file://$PWD/$1#$2" 2>/dev/null
  echo "$4.png"
}

for theme in dark light; do
  render banner.html  "$theme" 400 "banner-$theme"
  render intro.html   "$theme" 340 "intro-$theme"
  for i in 0 1 2; do
    render card.html "$theme-$i" 280 "service-$((i + 1))-$theme"
  done
  render process.html "$theme" 460 "process-$theme"
  render closing.html "$theme" 390 "closing-$theme"
done
