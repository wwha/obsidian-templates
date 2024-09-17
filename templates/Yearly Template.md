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

```dataviewjs
dv.span("**🏋️ Exercise 🏋️**")

const currentYear = Number(dv.current().file.name.match(/\d{4}/)?.[0]);

const calendarData = {
    year: currentYear,
    colors: {
        red: ["#ff9e82","#ff7b55","#ff4d1a","#e73400","#bd2a00",]
    },
    entries: []
}

for(let page of dv.pages('"Journal/Daily"').where(p=>p.exercise)){
    calendarData.entries.push({
        date: page.file.name,
        intensity: page.exercise
    })
       
}

renderHeatmapCalendar(this.container, calendarData)
```

```dataviewjs
dv.span("** Meditation 🧘‍♂️ **")

const currentYear = Number(dv.current().file.name.match(/\d{4}/)?.[0]);

const calendarData = {
    year: currentYear,
    colors: {
        blue: ["#03b6fc"]
    },
    entries: []
}

for(let page of dv.pages('"Journal/Daily"').where(p=>p.meditation)){
    calendarData.entries.push({
        date: page.file.name,
        intensity: page.meditation
    })
       
}
renderHeatmapCalendar(this.container, calendarData)
```
```dataviewjs  
dv.span("**Sleep Log**")  
  
// Extract the year from the current file name 
const currentYear = dv.current().file.name.match(/\d{4}/)?.[0]; 
// Filter pages to include only those that match the current year
const pages = dv.pages('"Journal/Daily"') .where(p => p.file.name.includes(currentYear)) .sort(p => p.file.name); 
const dates = pages.map(p => p.file.name).values  
const sleeps = pages.map(p => p.sleep).values  
  
const chartData = {  
type: 'line',  
data: {  
labels: dates,  
datasets: [{  
label: 'Sleep',  
data: sleeps,  
backgroundColor: [  
'rgba(53, 252, 167, 1)'  
],  
borderColor: [  
'rgba(138, 102, 204, 0.8)'  
],  
borderWidth: 1.5,  
spanGaps: true,  
}],  
},  
};  
window.renderChart(chartData, this.container)  
```

```dataviewjs  
dv.span("**Weight Log**")  
  
// Extract the year from the current file name 
const currentYear = dv.current().file.name.match(/\d{4}/)?.[0]; 
// Filter pages to include only those that match the current year
const pages = dv.pages('"Journal/Daily"') .where(p => p.file.name.includes(currentYear)) .sort(p => p.file.name); 
const dates = pages.map(p => p.file.name).values  
const weights = pages.map(p => p.weight).values  
  
const chartData = {  
type: 'line',  
data: {  
labels: dates,  
datasets: [{  
label: 'Weight',  
data: weights,  
backgroundColor: [  
'rgba(53, 252, 167, 1)'  
],  
borderColor: [  
'rgba(138, 102, 204, 0.8)'  
],
chartColor: ['rgba(255, 255, 255, 1)'],
borderWidth: 1.5,  
spanGaps: true,  
}],  
},  
};  
  
window.renderChart(chartData, this.container)  
```

```dataviewjs

dv.span("** Mood 🌄 **")

const hue1 = 13 //red
const hue2 = 132 //green

const currentYear = Number(dv.current().file.name.match(/\d{4}/)?.[0]);

const calendarData = { 
    year: currentYear,
    intensityScaleStart: 1,
    intensityScaleEnd: 5,
    colors: {   // optional, defaults to green
        red2greenX21: [
            `hsl(${hue1}, 100%, 37%)`,     // 1 - darkest red (worst mood)
            `hsl(${hue1}, 100%, 50%)`,     // 2 - 
            `hsl(${hue1}, 100%, 60%)`,     // 3 - 
            `hsl(${hue1}, 100%, 77%)`,     // 4 - lightest red
            `hsl(60, 75%, 74.5%)`,             // 5 - gray (neutral mood)
            `hsl(${hue2*0.7}, 70%, 72%)`,  // 6 - lightest green
            `hsl(${hue2*0.85}, 43%, 56%)`, // 7 - 
            `hsl(${hue2}, 49%, 36%)`,      // 8 - 
            `hsl(${hue2}, 59%, 24%)`,      // 9 - darkest green (best mood)
        ],
    },
    entries: [] // populated in the DataviewJS loop below
}

for(let page of dv.pages('"Journal/Daily"').where(p=>p.mood)){ 

    calendarData.entries.push({
        date: page.file.name, 
        intensity: page.mood,
    })    
}

renderHeatmapCalendar(this.container, calendarData)
```

```dataviewjs
dv.span("** Prayer 🙏 **")

const currentYear = Number(dv.current().file.name.match(/\d{4}/)?.[0]);

const calendarData = {
    year: currentYear,
    colors: {
        oldGithubGreen11:[
            "hsl(65, 83%, 88%)",
            "hsl(70, 77%, 78%)",
            "hsl(80, 62%, 72%)",
            "hsl(95, 52%, 66%)",
            "hsl(112, 45%, 61%)",
            "hsl(125, 43%, 56%)",
            "hsl(132, 41%, 49%)",
            "hsl(132, 45%, 43%)",
            "hsl(132, 49%, 36%)",
            "hsl(132, 54%, 29%)", 
            "hsl(132, 59%, 24%)",
        ]
    },
    entries: []
}

for(let page of dv.pages('"Journal/Daily"').where(p=>p.prayer)){
    calendarData.entries.push({
        date: page.file.name,
        intensity: page.prayer
    })
       
}

renderHeatmapCalendar(this.container, calendarData)
```

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
