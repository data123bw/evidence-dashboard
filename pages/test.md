```sql botswana_demo
SELECT * FROM (
    VALUES
        ('CENTRAL', 420000),
        ('CHOBE', 35000),
        ('FRANCISTOWN', 180000),
        ('GABORONE', 320000),
        ('GHANZI', 45000),
        ('JWANENG', 55000),
        ('KGALAGADI', 40000),
        ('KGATLENG', 95000),
        ('KWENENG', 210000),
        ('LOBATSE', 70000),
        ('NORTH EAST', 85000),
        ('NORTH WEST', 120000),
        ('SOUTH EAST', 110000),
        ('SOUTHERN', 90000),
        ('SELIBE PHIKWE', 65000),
        ('SOWA TOWN', 30000)
) AS t(district_name, total_views)
```

 <AreaMap 
    data={botswana_demo}
    areaCol=district_name
    geoJsonUrl='/maps/botswana_districts.json'
    geoId='name'
    value=total_views
    height=500
    basemapUrl={`basemapUrl="https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png"`}
/>



```sql botswana_demos
SELECT * FROM (
    VALUES
        ('CENTRAL', 420000, -22.3285, 24.6849),
        ('CHOBE', 35000, -18.8060, 24.6849),
        ('FRANCISTOWN', 180000, -21.1667, 27.5167),
        ('GABORONE', 320000, -24.6282, 25.9089),
        ('GHANZI', 45000, -21.7167, 21.7167),
        ('JWANENG', 55000, -24.8333, 25.3667),
        ('KGALAGADI', 40000, -26.0500, 20.7667),
        ('KGATLENG', 95000, -25.0667, 26.0333),
        ('KWENENG', 210000, -24.5667, 25.5000),
        ('LOBATSE', 70000, -25.2167, 25.6667),
        ('NORTH EAST', 85000, -21.5000, 28.5000),
        ('NORTH WEST', 120000, -19.8000, 23.5000),
        ('SOUTH EAST', 110000, -25.5000, 26.5000),
        ('SOUTHERN', 90000, -25.8333, 25.1667),
        ('SELIBE PHIKWE', 65000, -22.4167, 27.8333),
        ('SOWA TOWN', 30000, -21.8333, 26.1667)
) AS t(district_name, total_views, lat, long)
```
<BubbleMap 
    data={botswana_demos}
    lat=lat
    long=long
    value=total_views
    valueFmt=number
    size=total_views
    sizeFmt=number
    pointName=district_name
    tooltipType=hover
    tooltip={[
        {id: 'district_name', showColumnName: false, valueClass: 'text-xl font-semibold'},
        {id: 'total_views', fmt: 'number', fieldClass: 'text-gray-500', valueClass: 'text-blue-600 font-bold'}
    ]}
    height=500
    basemap={`https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.{ext}`}
    attribution='© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
/>
