SELECT
    -- 🔑 Keys
    f.post_id,

    -- 👤 Influencer
    f.influencer_id,
    i.influencer_name,
    i.follower_count,

    -- 📅 Date (ANALYTICS DATE)
    f.date_id,
    d.full_date,
    d.year,
    d.month,
    d.month_name,
    d.campaign_period,

    -- 🎬 Content
    f.content_id,
    c.topic_name,

    -- 👥 Audience
    f.audience_id,
    a.percent_women,
    a.percent_men,
    a.age_18_24,
    a.age_25_34,
    a.age_35_44,
    a.age_other,

    -- 📊 Metrics
    f.total_views,
    f.reach,
    f.engagement_clean,
    f.engagement_rate_clean,
    f.avg_watch_time_seconds,
    f.total_watch_time_seconds,
    f.audience_retention_avg_percent_watched,

    -- ⚠️ KEEP but DO NOT use for trends
    f.date_reporting

FROM fact_post_performance f

LEFT JOIN dim_influencer i 
    ON f.influencer_id = i.influencer_id

LEFT JOIN dim_date d 
    ON f.date_id = d.date_id

LEFT JOIN dim_content c 
    ON f.content_id = c.content_id

LEFT JOIN dim_audience a 
    ON f.audience_id = a.audience_id