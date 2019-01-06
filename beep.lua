-- Beep using timer alarm --
timerId = 2
dly = 1000
-- use D2
ledPin = 2
-- set mode to output
gpio.mode(ledPin,gpio.OUTPUT)
ledState = 0
-- timer loop
tmr.alarm( timerId, dly, 1, function()
  ledState = 1 - ledState;
  -- write state to D4
  gpio.write(ledPin, ledState)
end)
