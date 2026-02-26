echo $1
echo $2
fvm flutter pub get
fvm dart scripts/init/setup_project.dart --appName $1 --package $2