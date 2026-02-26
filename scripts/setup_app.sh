echo "fvm flutter pub get"
fvm flutter pub get
echo "fvm dart scripts/init/setup_project.dart --appName \"$1\" --package \"$2\""
fvm dart scripts/init/setup_project.dart --appName "$1" --package "$2"