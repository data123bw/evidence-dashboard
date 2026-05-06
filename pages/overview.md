


```sql kpis
SELECT
    SUM(total_views) AS total_views,
    SUM(reach) AS total_reach,
    SUM(engagement_clean) AS total_engagement,

    SUM(engagement_clean) * 100.0 / NULLIF(SUM(reach), 0) AS engagement_rate,

    AVG(avg_watch_time_seconds) AS avg_watch_time

FROM post_performance_enriched

WHERE 1=1
    AND influencer_name LIKE '${inputs.influencer_filter.value}'
    AND month_name LIKE '${inputs.selected_month.value}'

```
```sql post_data
select * from supabase.post_performance_enriched
```

```sql influencer_options
SELECT DISTINCT influencer_name
FROM post_performance_enriched
WHERE influencer_name IS NOT NULL
ORDER BY influencer_name

```


```sql month_options
SELECT DISTINCT month_name
FROM post_performance_enriched
ORDER BY year, month
```
# 📊 Overview Dashboard

<Grid cols=2>
<Dropdown
    data={influencer_options}
    name=influencer_filter
    value=influencer_name
    title="Select Influencer"
>
    <DropdownOption value="%" valueLabel="All Influencers"/>
</Dropdown>

<Dropdown
    data={month_options}
    name=selected_month
    value=month_name
    title="Select Month"
>
    <DropdownOption value="%" valueLabel="All Months"/>
</Dropdown>
</Grid>



<Grid cols=5>
    <BigValue data={kpis} value="total_views" title="Total Views" fmt="num1m" />
    <BigValue data={kpis} value="total_reach" title="Total Reach" fmt="num1m" />
    <BigValue data={kpis} value="total_engagement" title="Total Engagement" fmt="num0k" />
    <BigValue data={kpis} value="engagement_rate" title="Engagement Rate" fmt='#,##0.00"% "' />
    <BigValue data={kpis} value="avg_watch_time" title="Avg Watch Time" fmt='#,##0.0"s"' />
</Grid>


```sql monthly_trend
SELECT
    year,
    month,
    month_name,
    campaign_period,

    SUM(total_views) AS views,
    SUM(engagement_clean) AS engagement

FROM post_performance_enriched
GROUP BY year, month, month_name, campaign_period
ORDER BY year, month
```

## 📅 Performance Over Time
<Grid cols=2>
    <!-- Left Column: Views -->
    <BarChart
        data={monthly_trend}
        x="month_name"
        y="views"
        title="Monthly Views"
        xAxisTitle="Month"
        yAxisTitle="Views"
        yFmt="num1m"
        color="#1f77b4"
        labels={true}
        labelPosition="inside"
    />

    <!-- Right Column: Engagement -->
    <BarChart
        data={monthly_trend}
        x="month_name"
        y="engagement"
        title="Monthly Engagement"
        yFmt="num0k"
        color="#ff7f0e"
        labels={true}
        labelPosition="inside"
    />
</Grid>

## 👤 Influencer Performance
 

 

```sql influencer_performance
SELECT
    influencer_name,

    COUNT(post_id) AS total_posts,

    SUM(total_views) AS total_views,
    SUM(reach) AS total_reach,
    SUM(engagement_clean) AS total_engagement,

    -- ✅ weighted engagement rate (correct way)
    SUM(engagement_clean) * 100.0 / NULLIF(SUM(reach), 0) AS engagement_rate,

    AVG(avg_watch_time_seconds) AS avg_watch_time

FROM post_performance_enriched
GROUP BY influencer_name
ORDER BY total_views DESC
```

<DataTable 
    data={influencer_performance}
    title="Influencer Performance"
    columns={[
        { name: "influencer_name", label: "Influencer" },
        { name: "total_posts", label: "Total Posts", fmt: "num0" },
        { name: "total_views", label: "Total Views", fmt: "num1m" },
        { name: "total_reach", label: "Total Reach", fmt: "num1m" },
        { name: "total_engagement", label: "Total Engagement", fmt: "num0k" },
        { name: "engagement_rate", label: "Engagement Rate", fmt:'#,##0.00"% "' },
        { name: "avg_watch_time", label: "Avg Watch Time (s)", fmt:'#,##0.0"s"' }
    ]}
/>


<BarChart 
    data={influencer_performance} 
    x="influencer_name" 
    y="engagement_rate" 
    title="Engagement Rate by Influencer"
    xAxisTitle="Influencer"
    yAxisTitle="Engagement Rate (%)"
    yFmt='#,##0.00"% "'
    color="#2ca02c" 
    labels={true}
    labelPosition="inside"
/>


## 🎬 Content Performance
```sql content_performance
SELECT
    topic_name,

    COUNT(post_id) AS total_posts,

    SUM(total_views) AS total_views,
    SUM(reach) AS total_reach,
    SUM(engagement_clean) AS total_engagement,

    -- ✅ weighted engagement rate
    SUM(engagement_clean) * 1.0 / NULLIF(SUM(reach), 0) AS engagement_rate,

    AVG(avg_watch_time_seconds) AS avg_watch_time,

    AVG(audience_retention_avg_percent_watched) AS avg_retention
FROM post_performance_enriched
GROUP BY topic_name
ORDER BY total_views DESC
```
 
```sql engagement_pie
SELECT
    topic_name AS name,
    SUM(engagement_clean) AS value
from supabase.post_performance_enriched 
GROUP BY topic_name
ORDER BY value DESC
```

```sql retention_pie
SELECT
    topic_name AS name,
    ROUND(AVG(audience_retention_avg_percent_watched), 2) AS value
FROM supabase.post_performance_enriched
GROUP BY topic_name
ORDER BY value DESC
```


<ECharts config={
{
title: {
text: 'Total Engagement by Topic',
left: 'left',
top: 10
},
tooltip: {
trigger: 'item',
formatter: function(params) {
let val = params.value;
let formatted = val >= 1000 ? (val/1000).toFixed(1) + 'K' : val;
return params.name + ': ' + formatted + ' (' + params.percent + '%)';
}
},
series: [
{
name: 'Engagement',
type: 'pie',
radius: '65%',
data: [...engagement_pie],
label: {
show: true,
formatter: function(params) {
let val = params.value;
let formatted = val >= 1000 ? (val/1000).toFixed(1) + 'K' : val;
return params.name + '\n' + formatted;
},
fontSize: 13,
fontWeight: 'bold'
},
labelLine: {
show: true
}
}
]
}
}/>

<BarChart
    data={content_performance}
    x="topic_name"
    y="total_views"
    title="Views by Content Topic"
    xAxisTitle="Topic"
    yAxisTitle="Total Views"
    yFmt="num1m"
    labels={true}
    labelFmt="num1m"
    labelPosition="inside"
    height={500}
/>

<ECharts config={
{
title: {
text: 'Audience Retention by Topic',
left: 'left',
top: 10
},
tooltip: {
trigger: 'item',
formatter: '{b}: {c}% ({d}%)'
},
series: [
{
name: 'Audience Retention',
type: 'pie',
radius: ['40%', '70%'],
data: [...retention_pie],
label: {
show: true,
formatter: '{b}\n{c}%',
fontSize: 13,
position: 'outside'
},
labelLine: {
show: true
}
}
]
}
}/>