---
week: <% moment(tp.file.title).format("gggg-[W]WW")%>
weekday: <% tp.date.now("dddd", 0, tp.file.title,"YYYY-MM-DD")%>
aliases: 
location:
mood: 
tag:
 - Daily
sleep:
weight:
prayer:
meditation:
exercise: 
study:
stretch: 
---
<%*
await tp.file.move(`Journal/Daily/${tp.file.title}`);

let titleDate = moment(tp.file.title);

// # 2023/01/01 - Sunday
tR += '# ' + titleDate.format('dddd, DD MMMM YYYY') + '\n';

// 2023 / Q1 / January / Week 1
tR += '[[' + titleDate.format('YYYY') + ']] / ';
tR += '[[' + titleDate.format('YYYY-[Q]Q') + '|' + titleDate.format('[Q]Q') + ']] / ';
tR += '[[' + titleDate.format('YYYY-MM') + '|' + titleDate.format('MMMM') + ']] / ';
tR += '[[' + titleDate.format('gggg-[W]WW') + '|' + titleDate.format('[Week] w') + ']]';
tR += '\n\n';

// ❮ 2022-12-31 | 2023-01-01 | 2023-01-02 ❯
tR += '❮ [[' + titleDate.subtract(1, 'days').format('YYYY-MM-DD') + ']]';
tR += ' | ' + titleDate.add(1, 'days').format('YYYY-MM-DD') + ' | ';
tR += '[[' + titleDate.add(1, 'days').format('YYYY-MM-DD') + ']] ❯';
titleDate.subtract(1, 'days');
%>

```dataviewjs
// List of gratitudes
let gratitudes = [];

// Extract gratitudes from pages that have them
dv.pages()
	.where(page => page.gratitude)
	.forEach(page => {
		dv.array(page.gratitude)
			.forEach(gratitude => {
				gratitudes.push({
					message: gratitude,
					page: page
				});
				})});

// List of awesome things
let learnings = [];
// Extract learnings from pages that have them
dv.pages()
	.where(page => page.learning)
	.forEach(page => {
		dv.array(page.learning)
			.forEach(learning => {
				learnings.push({
					message: learning,
					page: page
				});
				})});

let gratitudegreeting = gratitudes[Math.floor(Math.random()*gratitudes.length)] 
let learninggreeting = learnings[Math.floor(Math.random()*learnings.length)]

dv.paragraph("*Practice gratitude:* " + gratitudegreeting.message + " (" + gratitudegreeting.page.file.link + ")" + "<br>" + "*A random learning:* " + learninggreeting.message + " (" + learninggreeting.page.file.link + ")");
```
Test
```dataviewjs
(async () => {
	// Helper to extract "Gratitude:: ..." from file contents
	function extractGratitudeFromContent(content) {
		const regex = /^gratitude::\s*(.+)$/gim;
		let results = [];
		let match;
		while ((match = regex.exec(content)) !== null) {
			results.push(match[1].trim());
		}
		return results;
	}

	// Helper to extract "Learning:: ..." from file contents
	function extractLearningFromContent(content) {
		const regex = /^learning::\s*(.+)$/gim;
		let results = [];
		let match;
		while ((match = regex.exec(content)) !== null) {
			results.push(match[1].trim());
		}
		return results;
	}

	let gratitudes = [];
	let learnings = [];
	const files = app.vault.getMarkdownFiles();

	for (let file of files) {
		const content = await app.vault.read(file);
		const page = dv.page(file.path);

		// From Dataview fields
		if (page && page.gratitude) {
			dv.array(page.gratitude).forEach(g => gratitudes.push({ message: g, page }));
		}
		if (page && page.learning) {
			dv.array(page.learning).forEach(l => learnings.push({ message: l, page }));
		}

		// From file body
		extractGratitudeFromContent(content).forEach(g => gratitudes.push({ message: g, page }));
		extractLearningFromContent(content).forEach(l => learnings.push({ message: l, page }));
	}

	let gratitudegreeting = gratitudes.length > 0 ? gratitudes[Math.floor(Math.random()*gratitudes.length)] : {message: "No gratitude found", page: {file: {link: ""}}};
	let learninggreeting = learnings.length > 0 ? learnings[Math.floor(Math.random()*learnings.length)] : {message: "No learning found", page: {file: {link: ""}}};
	dv.paragraph("*Practice gratitude:* " + gratitudegreeting.message + " (" + (gratitudegreeting.page.file?.link ?? "") + ")" + "<br>" + "*A random learning:* " + learninggreeting.message + " (" + (learninggreeting.page.file?.link ?? "") + ")");
})();
```
<% tp.web.daily_quote() %>

![[Journal/Weekly/<%moment(tp.file.title).format("gggg-[W]WW")%>#Goals for this week:]]

## What am I grateful for?
1. Gratitude:: 

## Highlights of the day:
1. Highlight:: 

## What did I learn today?
1. Learning:: 

## What good have I done today?
1. Good:: 

## What excited or drained me?
1. Exciting::
2. Draining:: 

#### Random notes
```dataviewjs
const noOfNotes = 3

app.vault.getFiles()
const files = app.vault.getFiles().filter(f => !f.path.includes("Journal") && !f.path.includes("Templates") && !f.path.includes("textgenerator") && !f.path.includes("Assets"))
const random = Math.floor(Math.random() * (files.length - 1))
const randomNote = files[random]

for (let i = 0; i < noOfNotes; i++) {
  const random = Math.floor(Math.random() * 
                            (files.length - 1))
  const randomNote = files[random] 
  dv.paragraph('[[' + randomNote.basename + ']]')
  }
```

> [!note]- Files created on this day
>```dataview  
>LIST WHERE file.cday = date(this.file.name)
>```

