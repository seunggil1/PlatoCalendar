# pre-commit.sh
# Git 저장소에서 .git/hooks/pre-commit 훅을 생성해 주는 스크립트 예시입니다.

# 1) pre-commit 훅에 들어갈 내용 정의
HOOK_CONTENT='
error_messages=""

fix_output=$(dart fix --apply 2>&1)
if ! echo "$fix_output" | grep -q "Nothing to fix!"; then
    error_messages="${error_messages}\n\n⚠️ dart fix --apply: 자동 수정 사항이 적용되었습니다.\n${fix_output}"
fi

format_output=$(dart format . 2>&1)
if ! echo "$format_output" | grep -Eq "0 changed|no files"; then
    error_messages="${error_messages}\n\n⚠️ dart format: 코드 포맷이 적용되었습니다.\n${format_output}"
fi

# analyze_result=$(flutter analyze 2>&1 | grep -Ei "error • ")
# if [ -n "$analyze_result" ]; then
#     error_messages="${error_messages}\n\n⚠️ flutter analyze: 정적 분석 결과 문제가 발견되었습니다. 아래 내용을 확인하세요:\n${analyze_result}"
# fi

if [ -n "$error_messages" ]; then
    error_messages="변경 내용을 확인한 후 다시 커밋해주세요. ${error_messages}"
    printf "%b\\n" "$error_messages" >&2
    exit 1
fi

exit 0
'

# 2) pre-commit 훅을 작성할 위치
HOOK_FILE=".git/hooks/pre-commit"

# 3) 훅 파일 쓰기
# 만약 기존에 pre-commit이 있다면 덮어쓰게 됩니다. 백업을 원하시면 사전에 처리하세요.
echo "Creating pre-commit hook at $HOOK_FILE ..."
echo "$HOOK_CONTENT" > "$HOOK_FILE"

# 4) 실행 권한 부여
chmod +x "$HOOK_FILE"

echo "Done. pre-commit hook has been set up."
