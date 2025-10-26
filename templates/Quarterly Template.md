<%*
tR = ""; // Initialize output buffer

// Move file into the correct folder
await tp.file.move(`Journal/Quarterly/${tp.file.title}`);

let quarter = moment(tp.file.title, 'YYYY-[Q]Q');

// # 2023 Q1
tR += '# ' + quarter.format('YYYY [Q]Q') + '\n';

// Year link
tR += '[[' + quarter.format('YYYY') + ']]\n\n';

// ❮ Q4 | Q1 | Q2 ❯
tR += '❮ [[' + quarter.clone().subtract(1, 'quarters').format('YYYY-[Q]Q|[Q]Q') + ']]';
tR += ' | ' + quarter.format('[Q]Q') + ' | ';
tR += '[[' + quarter.clone().add(1, 'quarters').format('YYYY-[Q]Q|[Q]Q') + ']] ❯\n\n';

// Month navigation (Jan–Mar style)
const startOfQuarter = quarter.clone().startOf('quarter');
const endOfQuarter = quarter.clone().endOf('quarter');
let m = startOfQuarter.clone();
let monthLinks = [];
while (m.isSameOrBefore(endOfQuarter)) {
    monthLinks.push('[[' + m.format('YYYY-MM|MMMM') + ']]');
    m.add(1, 'month');
}
tR += monthLinks.join(' - ') + '\n\n';

tR += '---\n\n';

tR += `## Summary

> Insert quarterly summary here

## Months
`;

let cursor = startOfQuarter.clone();
while (cursor.isSameOrBefore(endOfQuarter)) {
    const monthName = cursor.format("MMMM");
    const monthFile = cursor.format("YYYY-MM-[M]");
    tR += `### ${monthName}\n![[${monthFile}#Monthly summary]]\n\n`;
    cursor.add(1, 'month');
}

tR; // Return all content
%>
