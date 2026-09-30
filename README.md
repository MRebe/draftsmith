# Draftsmith

A Claude Code skill that removes the rhetorical habits which make generated prose read as
machine-written.

It applies to text a person reads: interface labels, headings, subtitles, empty states, error
messages, README files, design notes, slides and decks, emails, release notes. It works in any
output language, and it treats cross-language flourishes as a separate failure mode.

## The problem

Generated prose is fluent and still recognisable as generated. The cause is not any single
sentence, it is the density of rhetorical moves.

A person writing documentation produces about one image per page, usually by accident, and
often deletes it on reread. A model puts one in every paragraph: a metaphor in the subtitle, a
contrast in the second sentence, a short rhythmic closer at the end. Each is defensible alone.
Together they signal that the text was optimised for sound rather than for the reader.

## What it changes

```
before   A fresh skin over the existing app, isolated from everything else.
after    Applies to the report module only. Existing styles are untouched.

before   The form notices right away.
after    The form shows the error on blur.

before   Values are read at runtime, not copied by hand.
after    Values are read at runtime from tokens.css.

before   Only three levels: background, surface, sunken.
after    Three levels: background, surface, sunken.
```

Two of these are longer than the original. Draftsmith does not ask for shorter text. It asks
for the mechanism instead of the image, and precision usually costs words.

## What it covers

A decision that comes before drafting: whether to write anything here, and in what form. Name
the question the reader has at this point; if there is no question, text there is an
interruption. Prose is for reasoning - a set of values is a table, a sequence is a numbered
list, a single fact is a label. When the brief asks for text that should not exist, the skill
says to leave the slot empty and report which one and why, rather than fill it.

Nine drafting habits, each with the replacement: imagery, personification, the closing
flourish, "X not Y" used for rhythm, lists of three padded from two, essayist connectives,
emphatic intensifiers, the making-of opening, and headings restated as a first sentence.

A separate set of rules for microcopy - labels, buttons, column headers, menu items - where the
failures differ from the ones in prose: use the ordinary word rather than the more interesting
one, reuse the term the product already uses instead of coining a better one, keep capitalisation
consistent, and treat available space as a hard limit. Microcopy is the one place the skill
inverts its own preference for precision over length.

Rules for copy that reaches the screen through a key rather than being written in the template -
i18n files, translation tables, properties files, SQL seed scripts. The format does not change
what the string is, and a key named `subtitle` is not an obligation to produce a subtitle: when
it has nothing to say, the skill reports that the key should not exist rather than filling it.

A procedure for auditing an interface handed over as a screenshot, which is common during a
rebuild when the source still holds placeholders. List every string before judging any, judge
the slot rather than the sentence, and locate each proposed change in a file or a key, since a
correction nobody can find cannot be applied.

A three-step revision pass to run over prose already drafted: a deletion test, a substitution
test, and a frequency count with an explicit target.

An explicit permission to leave optional slots empty. Subtitles, taglines, section intros and
the secondary line of an empty state are optional by default. About half of the problem is not
badly written sentences, it is sentences that should not exist.

A section on writing in more than one language.

## Multilingual behaviour

Rhetorical moves do not survive translation, and this is where the worst output comes from.

"Under the hood" is dead idiom in English and reads as neutral. Translated into Italian as
"sotto il cofano" it reads as a flourish, because Italian technical documentation does not use
that construction. The same applies to "deep dive", "out of the box" and "battle-tested".

Draftsmith states that the register belongs to the target language: use the plain construction
that language's own documentation uses, rather than translating the English one. It also covers
local differences in formality, and says to drop wordplay when changing language rather than
approximating it.

## Installation

```
/plugin marketplace add MRebe/draftsmith
/plugin install draftsmith@draftsmith
```

Restart or reload Claude Code afterwards.

To use it without the plugin system, copy `skills/draftsmith/` into `~/.claude/skills/`.

## Usage

The skill loads on its own when a task involves writing prose. Its description covers both the
drafting case and the revision case.

To run the revision pass explicitly on something already written:

```
/draftsmith-revise <file or path>
```

Or ask for it in words, for example "rewrite this page description with draftsmith" or "run the
revision pass over the release notes".

### Activation hint

A skill cannot force Claude to use it, and a request such as "add this slide to the deck" reads
as file manipulation rather than writing. The plugin therefore ships a `UserPromptSubmit` hook.
When a prompt contains one of these words, it adds one line to Claude's context asking it to
invoke the skill:

```
pptx  ppt  docx  deck  slide  presentazione  presentation  email  e-mail  readme
release note  note di rilascio  documento  i18n  microcopy  ui copy  copywriting
```

Matching is case-insensitive, on whole words, and only on the prompt text. Generic words such as
"text", "copy" and "document" are left out because they appear in most coding prompts. A file
name such as `presentation.py` still matches. The line asks Claude to invoke the skill only if
the task writes, inserts or reviews text for people, so a false match costs one line of context.

To turn the hook off, set `DRAFTSMITH_HINT` to `off` in your shell or in the `env` block of
`settings.json`:

```json
{
  "env": {
    "DRAFTSMITH_HINT": "off"
  }
}
```

The hook is a POSIX `sh` script. On Windows it runs through Git Bash. Without Git Bash it fails
without blocking the prompt, and the skill still activates from its description.

## With many skills installed

Claude chooses a skill from a listing of names and descriptions loaded into its context. The
listing has a budget of 1% of the model's context window. When the installed skills exceed it,
Claude Code removes descriptions starting from the skills you invoke least, and keeps only their
names. A skill you have just installed has never been invoked, so its description is among the
first to go, and without it Claude has nothing to match your request against.

To check, run `/context` and look at the Skills row, which reports the listing size after the
budget is applied. `/doctor` estimates the listing's cost and names its biggest contributors, and
`/skill-doctor` finds skills you never use.

To make room:

| Option | Where | Effect |
| :- | :- | :- |
| `skillListingBudgetFraction` | `settings.json` | Budget as a fraction of the context window, for example `0.02` for 2% |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET` | `env` block of `settings.json`, or shell | Budget as a fixed number of characters |
| `skillListingMaxDescChars` | `settings.json` | Characters kept per skill description, 1,536 by default. Lowering it shortens every entry |
| `skillOverrides` with `"name-only"` | `settings.json` | Lists one skill without its description. Applies to personal and project skills only |
| `/plugin` | Claude Code | Disables plugins you do not use. Plugin skills are not affected by `skillOverrides`, so this is the way to remove them from the listing |

Setting names and behaviour are from the
[skills documentation](https://code.claude.com/docs/en/skills.md#skill-descriptions-are-cut-short).

## What it does not do

It does not shorten text. Many of its corrections are longer.

It does not remove contrast. Ruling out a real alternative is content: "separator between
cards: a line, never a shadow" forbids something a reader might otherwise do, and it stays.

It does not make prose impersonal. "Run the script before deploying" is preferred over "the
script should be run prior to deployment".

It does not apply to identifiers, code comments, log lines, commit messages, or conversational
replies. Strings a user reads are in scope even when they live in a source file - a label in a
component template is interface copy, not code. For explicitly persuasive copy such as a landing
page hero, the habit list relaxes but the frequency target still holds: one image per page, not
one per paragraph.

## Contributing

The habit list came from a small set of real cases. The useful contribution is more of them:
open an issue with a piece of generated prose that reads wrong to you, the language it was in,
and where it appeared. Cases that the current nine habits fail to catch are the most valuable,
because they show where the list is incomplete.

Cases where the skill did not activate when it should have are useful too. The `evals/`
directory holds activation tests for
[`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals.md), which needs Claude Code
v2.1.269 or later. Each case checks whether Claude invoked the skill for one prompt. Run them
from the repository root:

```
claude plugin eval . --tag activation --ablation none
```

`--ablation none` matters here: in a comparison with the no-plugin baseline, checks on skill
invocation are reported but not scored. An eval run loads only this plugin, so the listing
budget described above never applies there. The tests cover the description and the hook
together.

## License

MIT. See [LICENSE](LICENSE).
