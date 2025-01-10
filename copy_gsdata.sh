echo " > Copying gsdata into Tracker"
cp runner/TrackerEditor/gsdata runner/Tracker/data/db/data.json

echo " > Copying gsdata into Release"
mkdir -p release/db
cp runner/TrackerEditor/gsdata release/db/gsdata
cp runner/TrackerEditor/gsdatab release/db/gsdatab

echo "DONE"
read