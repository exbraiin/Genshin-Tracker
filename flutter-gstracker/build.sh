echo " > Running build"
flutter build windows

echo " > Copy to runner"
mkdir -p ../runner/Tracker
cp -R build/windows/x64/runner/Release/* ../runner/Tracker
