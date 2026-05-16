require "import"
-- Import only the essential service class if the full androlua package is missing
import "com.androlua.LuaTimer"

function skipAds()
  -- Using a safer way to check and click
  local result = service.click({{"Skip ad"}})
  if result then
    service.speak("Done")
  end
  return true
end

-- Using the built-in service.timer which is more stable in Jieshuo
-- It takes the function and the interval in milliseconds
service.timer(skipAds, 2000)

return true