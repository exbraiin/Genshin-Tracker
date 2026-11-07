echo " > Running build"
flutter build windows

echo " > Copy to runner"
mkdir -p ../runner/TrackerEditor
cp -R build/windows/x64/runner/Release/* ../runner/TrackerEditor
