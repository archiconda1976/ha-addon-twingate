import aiohttp
from datetime import timedelta
from homeassistant.helpers.update_coordinator import DataUpdateCoordinator
from .const import URL, SCAN_INTERVAL

class TwingateCoordinator(DataUpdateCoordinator):
    def __init__(self, hass):
        super().__init__(
            hass,
            logger=hass.logger,
            name="Twingate Connector",
            update_interval=timedelta(seconds=SCAN_INTERVAL),
        )

    async def _async_update_data(self):
        async with aiohttp.ClientSession() as session:
            async with session.get(URL, timeout=10) as resp:
                return await resp.json()
