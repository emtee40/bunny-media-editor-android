# First argument is the Gitlab API token, second argument is the version (tag name)

version_code=$(awk '/versionCode/ {getline following_line; if (following_line ~ /versionName/) print $2}' app/build.gradle)

idArm64=$(curl --header "PRIVATE-TOKEN: $1" --upload-file app/release/app-arm64-v8a-release.apk "https://gitlab.shinice.net/api/v4/projects/109/packages/generic/eu.artectrex.bunny/$2/app-release.apk?select=package_file" | jq -r .id)

curl --request POST --header "PRIVATE-TOKEN: $1" --data name="APK (arm64-v8a)" \
  --data url="https://gitlab.shinice.net/pixeldroid/bunny/-/package_files/$idArm64/download" \
  --data direct_asset_path="/package/bunny-$2-${version_code}02" "https://gitlab.shinice.net/api/v4/projects/109/releases/$2/assets/links"

idArm=$(curl --header "PRIVATE-TOKEN: $1" --upload-file app/release/app-armeabi-v7a-release.apk "https://gitlab.shinice.net/api/v4/projects/109/packages/generic/eu.artectrex.bunny/$2/app-release.apk?select=package_file" | jq -r .id)

curl --request POST --header "PRIVATE-TOKEN: $1" --data name="APK (arm)" \
  --data url="https://gitlab.shinice.net/pixeldroid/bunny/-/package_files/$idArm/download" \
  --data direct_asset_path="/package/bunny-$2-${version_code}01.apk" "https://gitlab.shinice.net/api/v4/projects/109/releases/$2/assets/links"

idx86=$(curl --header "PRIVATE-TOKEN: $1" --upload-file app/release/app-x86-release.apk "https://gitlab.shinice.net/api/v4/projects/109/packages/generic/eu.artectrex.bunny/$2/app-release.apk?select=package_file" | jq -r .id)

curl --request POST --header "PRIVATE-TOKEN: $1" --data name="APK (x86)" \
  --data url="https://gitlab.shinice.net/pixeldroid/bunny/-/package_files/$idx86/download" \
  --data direct_asset_path="/package/bunny-$2-${version_code}03.apk" "https://gitlab.shinice.net/api/v4/projects/109/releases/$2/assets/links"

idx8664=$(curl --header "PRIVATE-TOKEN: $1" --upload-file app/release/app-x86_64-release.apk "https://gitlab.shinice.net/api/v4/projects/109/packages/generic/eu.artectrex.bunny/$2/app-release.apk?select=package_file" | jq -r .id)

curl --request POST --header "PRIVATE-TOKEN: $1" --data name="APK (x86_64)" \
  --data url="https://gitlab.shinice.net/pixeldroid/bunny/-/package_files/$idx8664/download" \
  --data direct_asset_path="/package/bunny-$2-${version_code}04.apk" "https://gitlab.shinice.net/api/v4/projects/109/releases/$2/assets/links"


