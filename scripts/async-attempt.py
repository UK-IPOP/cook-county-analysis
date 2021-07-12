import geopandas
from geocoding import pharmacy_utils as pu
from geopy.geocoders import ArcGIS
from geopy.adapters import AioHTTPAdapter
from geopy.extra.rate_limiter import AsyncRateLimiter
import asyncio

df = pu.load_pharmacy_data()
# gdf = geopandas.GeoDataFrame(df)

# gdf["location"] = geopandas.tools.geocode(gdf.full_address, provider="arcgis")


async def main():
    async with ArcGIS(adapter_factory=AioHTTPAdapter, timeout=10) as geolocator:

        geocode = AsyncRateLimiter(geolocator.geocode, min_delay_seconds=1 / 20)
        locations = await asyncio.gather(*(geocode(s) for s in df.full_address.values))
        return locations


asyncio.run(main())
