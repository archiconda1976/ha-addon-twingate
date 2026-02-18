from homeassistant.components.sensor import SensorEntity
from .coordinator import TwingateCoordinator

async def async_setup_platform(hass, config, async_add_entities, discovery_info=None):
    coordinator = TwingateCoordinator(hass)
    await coordinator.async_config_entry_first_refresh()
    async_add_entities([TwingateStatusSensor(coordinator)])

class TwingateStatusSensor(SensorEntity):
    def __init__(self, coordinator):
        self.coordinator = coordinator
        self._attr_name = "Twingate Status"

    @property
    def state(self):
        return self.coordinator.data.get("status")

    async def async_update(self):
        await self.coordinator.async_request_refresh()
