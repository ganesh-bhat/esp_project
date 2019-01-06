d2 = 2 -- GPIO 1
d4 = 4 -- GPIO 2
d6 = 6

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        data = "<title>ESP Controller</title>";
        data = data.."<center><h1>ESP Controler</h1>";
        data = data.."<p>BLINK - (Pin4) <a href=\"?req=BLINK\"><button>ON</button></a>&nbsp;<a href=\"?req=BLOFF\"><button>OFF</button></a></p>";
        data = data.."<p>BEEP - (Pin2) <a href=\"?req=BEEP\"><button>ON</button></a>&nbsp;<a href=\"?req=BEOFF\"><button>OFF</button></a></p>";        
       
        if(_GET.req == "BLINK") then
              print("BLINK")
              dofile("blink.lua")
        elseif(_GET.req == "BEEP")then
              dofile("beep.lua")
              print("BEEP")
        elseif(_GET.req == "BLOFF")then
              print("BLOFF")
              tmr.stop(4)
              tmr.stop(0)
              gpio.write(4, 1)
        elseif(_GET.req == "BEOFF")then
              print("BEOFF")
              tmr.stop(2)
              gpio.write(2, gpio.LOW);
        end
        client:send(data);
        client:close();
        collectgarbage();
    end)
end)
