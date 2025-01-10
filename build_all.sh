echo "=== BUILD DATABASE ==="
cd dart-gsdatabase
sh build.sh
cd ..
echo ""

echo "=== BUILD TRACKER EDITOR ==="
cd flutter-gstrackereditor
sh build.sh
cd ..
echo ""

echo "=== BUILD TRACKER ==="
cd flutter-gstracker
sh build.sh
cd ..
echo ""

echo "DONE"
read