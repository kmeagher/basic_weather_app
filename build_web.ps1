flutter build web
flutter pub run flutter_launcher_icons
Get-ChildItem -Path public -Include *.* -File -Recurse | ForEach-Object { $_.Delete()}
xcopy build\web public /h /i /c /k /e /r /y