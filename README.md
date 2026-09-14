# Draftsmith

A Claude Code skill that removes the rhetorical habits which make generated prose read as
machine-written.

It applies to text a person reads: interface labels, headings, subtitles, empty states, error
messages, README files, design notes, slide text, release notes. It works in any output
language, and it treats cross-language flourishes as a separate failure mode.

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

## License

MIT. See [LICENSE](LICENSE).
