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
## Views Distribution Across Botswana Districts
 <AreaMap 
    data={botswana_demo}
    areaCol=district_name
    geoJsonUrl='/maps/botswana_districts.json'
    geoId='name'
    value=total_views
    height=500
    basemapUrl={`basemapUrl="https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png"`}
/>


