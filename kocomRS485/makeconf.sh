#!/bin/sh

CONFIG_FILE=/data/options.json
CONFIG_RS485=/share/kocom/rs485.conf

# CONFIG JSON 읽기
CONFIG=$(cat "$CONFIG_FILE")

# 기존 rs485.conf 파일 초기화
> "$CONFIG_RS485"

# CONFIG에서 키 목록을 가져와 순회
for i in $(echo "$CONFIG" | jq -r 'keys_unsorted[]'); do
  if [ "$i" = "Advanced" ]; then
      break
  fi
  
  # 섹션 헤더 생성
  echo "[$i]" >> "$CONFIG_RS485"
  
  # 키-값 변환하여 추가
  echo "$CONFIG" | jq --arg id "$i" -r '.[$id] | to_entries | map("\(.key)=\(.value|tostring)") | .[]' \
      | sed -e "s/false/False/g" -e "s/true/True/g" >> "$CONFIG_RS485"
done

