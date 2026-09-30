#!/bin/sh
# UserPromptSubmit hook: when the prompt mentions a deck, document, email or UI copy,
# add one line of context telling Claude to invoke the draftsmith skill.
# Disable with DRAFTSMITH_HINT=off (shell environment or the env block of settings.json).

case "$DRAFTSMITH_HINT" in
  off|0|false) exit 0 ;;
esac

# Keep only the value of the "prompt" field, so paths in cwd or transcript_path do not
# match. Escaped newlines and tabs become spaces so word matching still works.
prompt=$(sed -n 's/.*"prompt"[[:space:]]*:[[:space:]]*"//p' \
  | sed -E 's/^(([^"\\]|\\.)*)".*/\1/' \
  | sed 's/\\[nrt]/ /g')

[ -z "$prompt" ] && exit 0

keywords='pptx|ppt|docx|decks?|slides?|presentazion[ei]|presentations?|e-?mails?|readme|release notes?|note di rilascio|document[oi]|i18n|microcopy|ui copy|copywriting'

if printf '%s\n' "$prompt" | grep -q -i -w -E "$keywords"; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"draftsmith: this prompt may involve text written for people (slides, documents, emails, UI copy). If the task writes, inserts or reviews such text, invoke the draftsmith:draftsmith skill first, including when the text is supplied by someone else or goes through a script."}}'
fi

exit 0
