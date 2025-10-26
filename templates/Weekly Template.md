---
Location:
Tags: weeklyreviews
Aliases:
Enjoyment:
Date: <%moment(tp.file.title).startOf('isoWeek').format("YYYY-MM-DD") %>
---
<%*
await tp.file.move(`Journal/Weekly/${tp.file.title}`);

let weekMoment = moment(tp.file.title);

// # 2023 Week 1
tR += '# ' + weekMoment.format('gggg [Week] w') + '\n';

// 2023 / Q1 / January
tR += '[[' + weekMoment.format('YYYY') + ']] / ';
tR += '[[' + weekMoment.format('YYYY-[Q]Q|[Q]Q') + ']] / ';
tR += '[[' + weekMoment.format('YYYY-MM|MMMM') + ']]';

/**
 * If the week crosses a month, include the year/quarter/month that is crossed:
 * 2023 / Q1 / January - February              // Crosses a month
 * 2023 / Q1 / March - Q2 / April              // Crosses quarter and month
 * 2022 / Q4 / December - 2023 / Q1 / January  // Corsses year, quarter and month
 */
const endOfWeekMoment = weekMoment.clone().endOf('week');
if(weekMoment.format('M') != endOfWeekMoment.format('M')) {
	tR += ' - ';
	if (weekMoment.format('YYYY') != endOfWeekMoment.format('YYYY')) {
		tR += '[[' + endOfWeekMoment.format('YYYY') + ']] / ';
	}
	if (weekMoment.format('Q') != endOfWeekMoment.format('Q')) {
		tR += '[[' + endOfWeekMoment.format('YYYY-[Q]Q|[Q]Q') + ']] / ';
	}
	tR += '[[' + endOfWeekMoment.format('YYYY-MM|MMMM') + ']]';
}
tR += '\n\n';

// ❮ Week 52 | Week 1 | Week 2 ❯
tR += '❮ [[' + weekMoment.subtract(1, 'weeks').format('gggg-[W]ww|[Week] w') + ']]';
tR += ' | ' + weekMoment.add(1, 'weeks').format('[Week] w') + ' | ';
tR += '[[' + weekMoment.add(1, 'weeks').format('gggg-[W]ww|[Week] w') + ']] ❯';
weekMoment.subtract(1, 'weeks');
tR += '\n';

// Monday - Tuesday - Wednesday - Thursday - Friday - Saturday - Sunday
for (let day = 0; day < 7; day++) {
    tR += '[[' + weekMoment.startOf('isoWeek').add(day, 'days').format('YYYY-MM-DD|dddd') + ']]';
    if (day < 6) {
        tR += ' - ';
    }
}
%>
# <%moment(tp.file.title).startOf('isoWeek').format("MMM DD") %> - <%moment(tp.file.title).endOf('isoWeek').format("MMM DD") %> 

![[Journal/Monthly/<%moment(tp.file.title).format("YYYY-MM")%>#Goals for this month:]]

---
## Goals for this week:
1. 
2. 
3. 

---

## Summary
1.
2.

## Task

```dataviewjs
// --- CONFIG ---
const weekName = "<% tp.file.title %>"; // Templater injects the file title here
const folder = "Journal/Daily"; // path to your daily notes

// --- DETERMINE WEEK RANGE ---
let weekMoment = moment(weekName, "YYYY-[W]ww");
if (!weekMoment.isValid()) { // Fallback for when not in a template
    weekMoment = moment(this.current().file.name, "YYYY-[W]ww");
}
const start = dv.date(weekMoment.clone().startOf("isoWeek").format("YYYY-MM-DD"));
const end = dv.date(weekMoment.clone().endOf("isoWeek").format("YYYY-MM-DD"));

// --- LOAD ALL TASKS FROM THIS WEEK ---
const pages = dv.pages(`"${folder}"`)
    .where(p => p.file && p.file.day && p.file.day >= start && p.file.day <= end);
const tasks = pages.file.tasks;

// --- SAFE OUTPUT ---
if (!tasks || tasks.length === 0) {
    dv.paragraph("*(No tasks found for this week)*");
} else {
    dv.header(3, "✅ Completed This Week");
    dv.taskList(tasks.filter(t => t.completed && t.completion && t.completion <= end));

    dv.header(3, "🆕 Created This Week");
    dv.taskList(tasks.filter(t => !t.completed && t.created && t.created >= start));

    dv.header(3, "⏳ Still Uncompleted");
    dv.taskList(tasks.filter(t => !t.completed && (!t.created || t.created < start)));
}

```
