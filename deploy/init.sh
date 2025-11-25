#!/bin/bash

# initialize environment

set -ex

source .env

# --- 필수 명령 확인 ---
for cmd in docker git; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "❌ Error: '$cmd' 명령을 찾을 수 없습니다. 설치 후 다시 실행하세요." >&2
    exit 1
  fi
done

echo "✅ 필수 명령 확인 완료 (docker, git)"

#  initialize mobius/

git clone https://github.com/IoTKETI/Mobius.git mobius
cd mobius
git checkout tags/2.5.15
sed -i '11s/\^//' package.json
sed -i '37s/localhost/mobius-db/' mobius.js
sed -i '50s/localhost/mobius-mqtt/' mobius.js
cat << EOF > conf.json
{
    "csebaseport": "7579",
    "dbpass": "$MYSQL_ROOT_PASSWORD"
}
EOF
cd ..

#  initialize thyme/

git clone https://github.com/IoTKETI/nCube-Thyme-Nodejs.git thyme
cd thyme
git checkout tags/2.3.2
patch thyme/conf.js < patches/thyme/conf.js.patch
cd ..

#  initialize tas/

cd tas
cd ..
