<%*
tR = ""; // initialize manual output buffer

await tp.file.move(`Journal/Monthly/${tp.file.title}`);

let month = moment(tp.file.title);

// # 2023 January
tR += '# ' + month.format('YYYY MMMM') + '\n';

// 2023 / Q1
tR += '[[' + month.format('YYYY') + ']] / ';
tR += '[[' + month.format('YYYY-[Q]Q|[Q]Q') + ']]\n\n';

// ❮ December | January | February ❯
tR += '❮ [[' + month.clone().subtract(1, 'months').format('YYYY-MM|MMMM') + ']]';
tR += ' | ' + month.format('MMMM') + ' | ';
tR += '[[' + month.clone().add(1, 'months').format('YYYY-MM|MMMM') + ']] ❯\n';

// Week links (navigation)
const thisMonth = month.month();
let weekCursor = month.clone().startOf('week');
let weekLinks = [];
do {
    weekLinks.push('[[' + weekCursor.format('YYYY-[W]ww|[Week] w') + ']]');
    weekCursor.add(1, 'weeks');
} while (weekCursor.month() === thisMonth);
tR += weekLinks.join(' - ') + '\n';
tR += '\n---\n\n';

// Dataview blocks (static text, not JS output)
tR += `\`\`\`dataview
TABLE aliases
FROM "Journal"
WHERE aliases != null
AND file.day.year = number(substring(this.file.name, 0, 4))
AND dateformat(date(file.name), "yyyy-MM") = replace(this.file.name, "M", "")
SORT file.day
\`\`\`

---

\`\`\`dataview
TABLE WITHOUT ID file.day.weekyear AS Week, learning
FROM "Journal/Daily"
WHERE learning != null
AND file.day.year = number(substring(this.file.name, 0, 4))
AND dateformat(date(file.name), "yyyy-MM") = replace(this.file.name, "M", "")
SORT file.day
\`\`\`

\`\`\`dataview
TABLE WITHOUT ID file.day.weekyear AS Week, highlight
FROM "Journal/Daily"
WHERE highlight != null
AND file.day.year = number(substring(this.file.name, 0, 4))
AND dateformat(date(file.name), "yyyy-MM") = replace(this.file.name, "M", "")
SORT file.day
\`\`\`

---

## Goals for this month:
1. 
2. 

---

## Summary

> Insert monthly summary here

## Weeks
`;

let startOfMonth = month.clone().startOf("month").startOf("week");
let endOfMonth = month.clone().endOf("month").endOf("week");
let cursor = startOfMonth.clone();

while (cursor.isSameOrBefore(endOfMonth)) {
    const weekName = cursor.format("[Week] ww");
    const weekFile = cursor.format("YYYY-[W]ww");
    tR += `### ${weekName}\n![[${weekFile}#Summary]]\n\n`;
    cursor.add(1, "week");
}

tR; // RETURN final content
%>
