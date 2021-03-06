# This script assumes you've run `python download_card_images.py` already
# So do that first if you haven't

# Oh and run `release.bat` in the client folder on a cmd terminal first

### DON'T NEED THIS ANYMORE
# Oh also you'll need docker running, so make sure to launch "Docker Quickstart Terminal"
# Then you'll need to turn off TLS on the tcp endpoint with
# >docker-machine ssh
# >cd /var/lib/boot2docker
# >sudo vi profile
# Turn DOCKER_TLS to "no"
# esc, :wq, enter, "exit"
# >docker-machine restart

set -e

rm -rf dist
mkdir dist
mkdir dist/twitch
mkdir dist/netlify

# Build twitch bundle
cd config && yarn install && yarn build && cd ..
cd overlay && yarn install && yarn build && cd ..
cd mobile && yarn install && yarn build && cd ..
mv config/dist dist/twitch/config
mv overlay/dist dist/twitch/overlay
mv mobile/dist dist/twitch/mobile


cd dist/twitch && zip -r ../twitch.zip * && cd ../..

# Build netlify bundle
cp -r cards dist/netlify/cards
cp logo.png dist/netlify
cp deckmaster-setup-2018.8.20.exe dist/netlify/deckmaster-windows-4.0-amd64.exe
echo "xxxxxx" > dist/netlify/version
