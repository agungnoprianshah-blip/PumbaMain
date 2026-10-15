-- ==================================================
-- PUMBA HUB | TAB | Hop Server
-- ==================================================
local Window = _G.YOKUDO_Window
if not Window then warn("Window not created") return end

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PLACE_ID = 107778070777162

local Tab = Window:Tab({Name = "Hop Server", Icon = "server"})

Tab:Section("Hop Server")

local ServerOptions = {}

Tab:Dropdown({
    Name = "Server List",
    Description = "Pilih server untuk join",
    Options = {},
    Placeholder = "Klik Scan dulu",
    Flag = "ServerHopList",
    Callback = function(selected)
        if not selected then return end
        local jobId = ServerOptions[selected]
        if not jobId then return end
        Window:Notify({Title = "Teleporting", Content = "Join server...", Duration = 3, Type = "Info"})
        local ok, err = pcall(function()
            TeleportService:TeleportToPlaceInstance(PLACE_ID, jobId, game.Players.LocalPlayer)
        end)
        if not ok then
            Window:Notify({Title = "Gagal", Content = tostring(err), Duration = 3, Type = "Error"})
        end
    end
})

local DropdownRef
Tab:Button({
    Name = "Scan Low Player Servers",
    Description = "Cari server dengan 1 player",
    Icon = "search",
    Style = "Primary",
    Callback = function()
        Window:Notify({Title = "Scanning", Content = "Mencari server...", Duration = 2, Type = "Info"})
        task.spawn(function()
            local all, seen, cursor, page = {}, {}, "", 0
            repeat
                page += 1
                local url = string.format(
                    "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s",
                    PLACE_ID, cursor)
                local ok, resp = pcall(function()
                    return HttpService:JSONDecode(game:HttpGet(url))
                end)
                if not ok or not resp or not resp.data then break end
                for _, s in ipairs(resp.data) do
                    if s.playing == 1 and s.id ~= game.JobId and s.maxPlayers > 1 and not seen[s.id] then
                        seen[s.id] = true
                        table.insert(all, s)
                    end
                end
                cursor = resp.next_cursor or ""
                task.wait(0.15)
            until cursor == "" or page >= 5

            if #all == 0 then
                Window:Notify({Title = "Hasil", Content = "Tidak ada server kosong", Duration = 3, Type = "Warning"})
                return
            end

            ServerOptions = {}
            local opts = {}
            for i, s in ipairs(all) do
                local label = "Server #" .. i .. " | " .. s.id:sub(1,8)
                opts[i] = label
                ServerOptions[label] = s.id
            end

            if DropdownRef then
                DropdownRef:Refresh(opts)
            end

            Window:Notify({Title = "Ditemukan", Content = #all .. " server", Duration = 3, Type = "Success"})
        end)
    end
})

-- Simpan referensi Dropdown
task.defer(function()
    task.wait(0.2)
    DropdownRef = Window.Flags and Window.Flags["ServerHopList"]
end)

print("✅ PUMBA Hop Server Tab Loaded")
