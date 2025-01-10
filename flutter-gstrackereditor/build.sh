echo " > Running build"
flutter build windows

echo " > Copy to runner"
mkdir -p ../runner/TrackerEditor
cp -R build/windows/x64/runner/Release/* ../runner/TrackerEditor

echo " > Compress to release"
cd build/windows/x64/runner/Release
rm -f TrackerEditor.zip
# tar -a -c -f TrackerEditor.zip *
7z a TrackerEditor.zip *
cd ../../../../..

echo " > Move to release"
mkdir -p ../release/
mv -f build/windows/x64/runner/Release/TrackerEditor.zip ../release/
