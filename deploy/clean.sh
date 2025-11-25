#!/bin/bash

# initialize environment

set -ex

echo "⚠️  이 스크립트는 프로젝트의 mobius, thyme 디렉토리를 삭제하고 초기화합니다."
read -p "정말로 진행하시겠습니까? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "❌ 취소되었습니다."
  exit 1
fi

docker compose down || true

rm -rf mobius
rm -rf thyme
rm -rf tas/node_modules tas/package-lock.json
