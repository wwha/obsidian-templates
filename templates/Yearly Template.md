<%*
tR = ""; // Initialize output buffer

// Move the file to correct folder
await tp.file.move(`Journal/Yearly/${tp.file.title}`);

let year = moment(tp.file.title, "YYYY");

// # 2023
tR += '# ' + year.format('YYYY') + '\n\n';

// ❮ 2022 | 2023 | 2024 ❯
tR += '❮ [[' + year.clone().subtract(1, 'years').format('YYYY') + ']]';
tR += ' | ' + year.format('YYYY') + ' | ';
tR += '[[' + year.clone().add(1, 'years').format('YYYY') + ']] ❯\n\n';

// Q1 - Q2 - Q3 - Q4 navigation
let q = year.clone().startOf('year');
let quarterLinks = [];
for (let i = 1; i <= 4; i++) {
    quarterLinks.push('[[' + q.format('YYYY-[Q]Q|[Q]Q') + ']]');
    q.add(1, 'quarter');
}
tR += quarterLinks.join(' - ') + '\n\n';

// Month navigation (Jan–Dec)
const monthLinks = Array.from({ length: 12 }, (_, i) =>
    '[[' + year.format('YYYY') + '-' + String(i + 1).padStart(2, '0') + '|'
    + moment().month(i).format('MMM') + ']]'
);
tR += monthLinks.join(' - ') + '\n\n';

tR += '---\n\n';

// Dataview sections
tR += `\`\`\`dataview
TABLE aliases
FROM "Journal/Weekly"
WHERE aliases != null
AND length(aliases) > 1
AND file.day.year = number(${year.format('YYYY')})
\`\`\`

\`\`\`dataview
TABLE aliases
FROM "Journal/Daily"
WHERE aliases != null
AND length(aliases) > 1
AND file.day.year = number(${year.format('YYYY')})
\`\`\`

---

## Summary

> Insert yearly summary here

## Quarters
`;

let cursor = year.clone().startOf("year");
while (cursor.isSameOrBefore(year.clone().endOf("year"))) {
    const quarterName = cursor.format("[Q]Q");
    const quarterFile = cursor.format("YYYY-[Q]Q");
    tR += `### ${quarterName}\n![[${quarterFile}#Summary]]\n\n`;
    cursor.add(1, "quarter");
}

tR; // Return final output
%>
