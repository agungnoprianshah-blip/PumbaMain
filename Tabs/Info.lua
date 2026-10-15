-- ==================================================
-- YOKUDO HUB | TAB | Info (Pumba Version)
-- ==================================================

local Window = _G.YOKUDO_Window

if not Window then
    warn("❌ Pumba Window belum dibuat!")
    return
end

local InfoTab = Window:Tab({ Name = "Info", Icon = "info" })

local DISCORD_LINK = "https://discord.gg/aKeK6avatS"

-- ==================================================
-- SECTION: HUB INFO
-- ==================================================
InfoTab:Section("YOKUDO HUB | Steal An Egg")

InfoTab:Paragraph({
    Name = "Join Group For Notification Update Script",
    Content = "Dapatkan update terbaru, fitur baru, dan support langsung dari komunitas kami di Discord."
})

-- ==================================================
-- BUTTON: COPY DISCORD LINK
-- ==================================================
InfoTab:Button({
    Name = "Copy Discord Link",
    Description = DISCORD_LINK,
    Icon = "copy",
    Style = "Primary",
    Callback = function()
        local ok = pcall(function() setclipboard(DISCORD_LINK) end)
        if ok then
            Window:Notify({
                Title = "Link Copied!",
                Content = DISCORD_LINK,
                Duration = 3,
                Type = "Success"
            })
        else
            Window:Notify({
                Title = "Gagal Copy",
                Content = "Executor tidak support setclipboard",
                Duration = 3,
                Type = "Error"
            })
        end
    end
})

-- ==================================================
-- BUTTON: JOIN DISCORD
-- ==================================================
InfoTab:Button({
    Name = "Join Discord Server",
    Description = "Salin link lalu paste di browser",
    Icon = "external-link",
    Callback = function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        Window:Notify({
            Title = "Link Disalin",
            Content = "Paste di browser untuk join Discord",
            Duration = 3,
            Type = "Info"
        })
    end
})

-- ==================================================
-- SECTION: ABOUT
-- ==================================================
InfoTab:Section("Tentang Script")

InfoTab:Paragraph({
    Name = "Info Versi",
    Content = "YOKUDO HUB - Steal An Egg\nBackend: Original Yokudo\nUI: Pumba Hub Edition\nAuthor: S4"
})

InfoTab:Label({
    Text = "Terima kasih sudah menggunakan script ini!",
    Color = Color3.fromRGB(150, 150, 180)
})

print("✅ Info Tab Loaded (Pumba)")
