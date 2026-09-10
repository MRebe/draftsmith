---
name: draftsmith
description: Use when writing any prose a person will read - UI labels, headings, subtitles, empty states, error messages, README and other documentation, design notes, slide text, release notes - in any language. Also use as a revision pass over prose already drafted. Removes the rhetorical habits that make generated text read as machine-written. Not for code, commit messages, or conversational replies.
---

# Draftsmith

## The rule

In technical writing, vividness comes from precision, not from figures of speech.

No slot has to be filled because it exists.

## Why the default output fails

Generated prose is fluent and still reads as machine-written. The cause is not any single
sentence. It is the density of rhetorical moves.

A person writing documentation produces maybe one image per page, usually by accident, and
often deletes it on reread. Generated prose puts one in every paragraph: a metaphor in the
subtitle, a contrast in the second sentence, a short rhythmic closer at the end. Each one is
defensible alone. Together they signal that the text was optimised for sound.

The second cause is register transfer. Published prose - magazine writing, product marketing,
essays - rewards rhythm and image, and that is most of what a model has read. Reference
documentation and interface copy are a different register: the reader arrived with a specific
question and wants to leave. A subtitle that sets a tone costs them attention and returns
nothing.

## The habits to remove

**Imagery.** Any word doing metaphorical work in a description of a real mechanism. "A fresh
skin over the existing app." "Every check becomes waste paper." The replacement is not a
blander image, it is the mechanism: "Every check stops applying, because the new route
bypasses the gateway." That is longer and it tells the reader why.

**Personification.** Interfaces, tests and code have no perceptions. "The form notices right
away", "the page tells you", "the test knows about the change". Replace with the observable
behaviour and its trigger: "the form shows the error on blur". The original hid the one detail
a reader needed - when.

**The closing flourish.** A short rhythmic sentence at the end of a paragraph, carrying no
fact. "And that is the whole mechanism." "Nothing else moves." It exists to end the paragraph
well. Delete it - the preceding sentence is already the end.

**"X, not Y" as a rhythm.** The contrast is content when Y is a real alternative someone might
choose: "Separator between cards: a line, never a shadow" forbids something. It is decoration
when Y was never on the table: "values are read at runtime, not copied by hand" - nobody
proposed copying them by hand. Keep the first kind. Cut the second to its positive half.

**A list of three when there are two.** "Fast, reliable and maintainable" often covers one
real property padded to a cadence. Count the items that are actually distinct and write that
many. Two is a normal number.

**Essayist connectives.** "Which is to say", "the point is", "it is worth writing down that",
"here is the thing", "and this is where it gets interesting". Each announces that a thought is
coming instead of stating it. Delete the announcement and keep the thought.

**Emphatic intensifiers.** "Only three levels", "simply add the flag", "just run the script".
"Only" and "just" editorialise about how easy something is, which the reader will judge for
themselves and may disagree with. Write "Three levels."

**The making-of.** Opening a reference page by explaining how the page was built, how the
values are sourced, or what the author decided. The reader opened a token table to find a hex
value. If the sourcing matters, it is a footnote, not the opening paragraph.

**Restating the heading.** A section called "Error handling" followed by "This section covers
how errors are handled." Start with the first real statement.

## Empty slots are valid output

These are optional by default: subtitle, tagline, page or section intro, the secondary line of
an empty state, slide subtitle, the description under a heading in a design system.

Write one only when there is a fact that has nowhere else to go - a constraint, a scope
boundary, a number, a warning. Otherwise leave it out.

A heading with no subtitle reads as deliberate. A heading with a decorative subtitle reads as
padded, and the padding is usually the first thing a reader notices.

## Revision pass

Run this over prose already drafted, sentence by sentence. It matters more than the drafting
rules, because the first draft will contain these habits regardless.

1. **Deletion test.** Remove the sentence. Does the reader lose a fact, a constraint, a number,
   an instruction, or a warning? If not, leave it removed.
2. **Substitution test.** Is any word carrying an image rather than a meaning? Replace it with
   the mechanism it stands for, even if the result is longer.
3. **Frequency check.** Count the rhetorical moves that survived. In reference material and
   interface copy the target is zero. In an argued document - a design note, a rationale, a
   post-mortem - one in the whole document is already noticeable.

## Across languages

The register belongs to the target language. Rhetorical moves do not survive translation.

"Under the hood" is dead idiom in English and reads as neutral. "Sotto il cofano" in an Italian
technical document reads as a flourish, because Italian documentation does not use it. Same for
"deep dive", "out of the box", "at its core", "battle-tested". When writing in a language other
than English, do not translate the English move. Use the plain construction that language's own
technical documentation uses - for the example above, "nell'implementazione" or "internamente".

Two related points:

- **Formality is local.** Languages differ in how much first person, direct address and
  contraction their technical writing tolerates. Match the convention of the target language
  rather than exporting the English one.
- **Wordplay does not port.** Alliteration, puns and rhythm in headings should be dropped when
  changing language, not approximated. An approximated pun reads worse than the plain noun.

## What this does not ask for

**Not "write less".** Many corrections here are longer than what they replace. Precision costs
words; decoration is what gets cut.

**Not "remove all contrast".** Ruling out a real alternative is content.

**Not "avoid judgement".** "This is slower than the batch path" is a fact with a comparison.
Keep it, and say by how much if you know.

**Not "sound impersonal".** Plain is not the same as passive or bureaucratic. "Run the script
before deploying" beats "the script should be run prior to deployment".

## Scope

Applies to: interface copy, documentation, design notes, slide text, release notes, error
messages, email and report text.

Does not apply to: code, code comments that follow the surrounding convention, commit messages,
conversational replies.

Explicitly persuasive copy - a landing page hero, a launch announcement - may want an image.
The frequency check still applies: one per page, not one per paragraph.
