<%*
await tp.file.move(`Journal/Yearly/${tp.file.title}`);

let year = moment(tp.file.title);

// # 2023
tR += '# ' + year.format('YYYY') + '\n\n\n';

// ❮ 2022 | 2023 | 2024 ❯
tR += '❮ [[' + year.subtract(1, 'years').format('YYYY') + ']]';
tR += ' | ' + year.add(1, 'years').format('YYYY') + ' | ';
tR += '[[' + year.add(1, 'years').format('YYYY') + ']] ❯';
year.subtract(1, 'years');
tR += '\n';

// Q1 - Q2 - Q3 - Q4
tR += '[[' + year.format('YYYY-[Q]Q|[Q]Q') + ']] - ';
tR += '[[' + year.add(1, 'quarters').format('YYYY-[Q]Q|[Q]Q') + ']] - ';
tR += '[[' + year.add(1, 'quarters').format('YYYY-[Q]Q|[Q]Q') + ']] - ';
tR += '[[' + year.add(1, 'quarters').format('YYYY-[Q]Q|[Q]Q') + ']]' + '\n';

tR += '[[' + year.format('YYYY') + '-' + '01|Jan]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '02|Feb]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '03|March]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '04|Apr]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '05|May]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '06|Jun]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '07|Jul]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '08|Aug]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '09|Sep]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '10|Oct]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '11|Nov]]' + ' - ';
tR += '[[' + year.format('YYYY') + '-' + '12|Dec]]';
%>

```dataview
TABLE aliases
FROM "Journal/Weekly"
WHERE aliases != null
where length(aliases) > 1
where file.day.year = 2023
```

```dataview
TABLE aliases
FROM "Journal/Daily"
WHERE aliases != null
where length(aliases) > 1
where file.day.year = 2023
```
