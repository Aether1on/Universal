if not getgenv().Config then
    getgenv().Config = {
        Headless = false,
        FakeDisplayName = "  Verified Guy ",
        FakeName = "lol",
        FakeId = 13886182,
    }
end

local players = game:GetService('Players')
local lp = players.LocalPlayer
local oldUserId = tostring(lp.UserId)
local oldName = lp.Name
local oldDisplayName = lp.DisplayName

-- Text replacement system only
local function processtext(text)
    if string.gsub(text, oldName, Config.FakeName) ~= text then
        return string.gsub(text, oldName, Config.FakeName)
    elseif string.gsub(text, oldUserId, Config.FakeId) ~= text then
        return string.gsub(text, oldUserId, Config.FakeId)
    elseif string.gsub(text, oldDisplayName, Config.FakeDisplayName) ~= text then
        return string.gsub(text, oldDisplayName, Config.FakeDisplayName)
    end
    if text ~= nil then
        return text
    end
    return ''
end

-- Replace existing UI text
for _, v in next, game:GetDescendants() do
    if v:IsA("TextBox") or v:IsA("TextLabel") or v:IsA("TextButton") then
        v.Text = processtext(v.Text)
        v.Name = processtext(v.Name)
        v.Changed:Connect(function(property)
            v.Text = processtext(v.Text)
            v.Name = processtext(v.Name)
        end)
    end
end

-- Replace new UI text
game.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("TextBox") or descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
        descendant.Text = processtext(descendant.Text)
        descendant.Name = processtext(descendant.Name)
        descendant.Changed:Connect(function()
            descendant.Text = processtext(descendant.Text)
            descendant.Name = processtext(descendant.Name)
        end)
    end
end)

-- DisplayName spoof
lp.DisplayName = Config.FakeDisplayName
