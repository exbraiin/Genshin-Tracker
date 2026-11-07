echo " > Copying gsdata into Tracker"
cp runner/TrackerEditor/.data/gsdata runner/Tracker/data/db/data.json

echo " > Copying gsdata into Release"
mkdir -p release/db
cp runner/TrackerEditor/.data/gsdata release/db/gsdata
cp runner/TrackerEditor/.data/gsdatab release/db/gsdatab

echo "DONE"
read