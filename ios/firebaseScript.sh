if [ "$CONFIGURATION" == "Debug-develop" ] || [ "$CONFIGURATION" == "Release-develop" ]; then
  cp Runner/develop/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-production" ] || [ "$CONFIGURATION" == "Release-production" ]; then
  cp Runner/production/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

