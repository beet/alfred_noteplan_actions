# Alfred Noteplan Actions

Alfred workflow for handy Noteplan actions.

**[Download current version](https://github.com/beet/alfred_noteplan_actions/raw/master/downloads/NotePlan%20Actions.alfredworkflow)**

I'm migrating across to Noteplan from Wunderlist which has an awesome ubiquitous quick add and search feature that I can't live without, so these actions are mainly to provide similar functionality for Noteplan through Alfred.

I'd also have preferred Noteplan to have provided native auto-completion of wiki links, but it does provide a means of copying a page's link.

The create link note action is just something I use personally.

## Open note

Keyword: `t`

Fuzzy search of calendar and text notes by title _(actually, currently by filename)_.

Can enter a date in `YYYYMMDD` or even `YYYY-MM-DD` format to jump to a specific calendar note.


## Quick add

Keyword: `q`

Create a task in today's calendar note from the entered text.

Appends to the end of the note by default, but to change to prepending to the beginning of the node, edit the Ruby script to change `mode=append` to `mode=prepend`.


## Insert wiki link

Keyword: `wl`

Insert a wiki link to any text note with fuzzy search of the page headings, which is how NotePlan interlinks pages internally.

## Create link note from URL

Keyword: `link`

Past in a URL, like `https://noteplan.co`, and this workdlow action will create a new note like:

```markdown
# Link - NotePlan - Organize Everything Bullet Journal Style

[NotePlan - Organize Everything Bullet Journal Style](https://noteplan.co)

#links
```

I usually add a short note beneath the link, and add some relevant tags to make the note easier to retrieve later.

## Insert hashtag

Keywork: `hashtag`

Autocomplete of hashtags would be super useful, but seeing as it's missing, you can quickly insert any of your existing hashtags using fuzzy search of all hashtags used in all text notes with this handy workflow.

Currently only allows one hashtag to be inserted at a time.

_(Actually just inserts it into whatever program you happen to be using via the clipboard)_
