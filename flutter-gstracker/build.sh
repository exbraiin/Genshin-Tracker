echo " > Running build"
flutter build windows

echo " > Copy to runner"
mkdir -p ../runner/Tracker
cp -R build/windows/x64/runner/Release/* ../runner/Tracker

echo " > Move static images"
cp -R assets/image/backgrounds/static/* build/windows/x64/runner/Release/data/flutter_assets/assets/image/backgrounds

echo " > Compress to release"
cd build/windows/x64/runner/Release
rm -f Tracker.zip
# tar -a -c -f Tracker.zip *
7z a Tracker.zip *
cd ../../../../..

echo " > Move to release"
mkdir -p ../release/
mv -f build/windows/x64/runner/Release/Tracker.zip ../release/
