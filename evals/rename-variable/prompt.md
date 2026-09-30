---
description: Identifier rename; should not trigger.
tags: [activation]
max_turns: 4
allowed_tools: [Read, Glob, Grep, Skill]
---

Rinomina questa variabile da tmp a retryCount:

let tmp = 0;
while (tmp < 3) { tmp++; send(); }
