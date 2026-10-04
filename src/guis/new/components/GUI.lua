local component = {
	Buttons = {},
	Type = 'MainWindow'
}

local window = Instance.new('TextButton')
window.AutoButtonColor = false
window.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
window.Name = 'GUICategory'
window.Position = UDim2.fromOffset(6, 60)
window.Text = ''
window.Parent = clickgui
component.Object = window
addBlur(window)
addCorner(window)
addDragHandler(window)
local logo = Instance.new('Frame')
logo.BackgroundColor3 = uipallet.SurfaceRaised
logo.BorderSizePixel = 0
logo.Name = 'LEGIONLogo'
logo.Position = UDim2.fromOffset(10, 7)
logo.Size = UDim2.fromOffset(26, 26)
logo.Parent = window
addCorner(logo, UDim.new(0, 7))
local logoStroke = Instance.new('UIStroke')
logoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
logoStroke.Color = uipallet.Accent
logoStroke.Thickness = 1
logoStroke.Transparency = 0.1
logoStroke.Parent = logo
local brandMark = Instance.new('TextLabel')
brandMark.BackgroundTransparency = 1
brandMark.BorderSizePixel = 0
brandMark.FontFace = uipallet.FontSemiBold
brandMark.Name = 'LEGIONMark'
brandMark.Size = UDim2.fromScale(1, 1)
brandMark.Text = 'L'
brandMark.TextColor3 = uipallet.Accent
brandMark.TextSize = 17
brandMark.TextXAlignment = Enum.TextXAlignment.Center
brandMark.TextYAlignment = Enum.TextYAlignment.Center
brandMark.Parent = logo
local wordmark = Instance.new('TextLabel')
wordmark.BackgroundTransparency = 1
wordmark.BorderSizePixel = 0
wordmark.FontFace = uipallet.FontSemiBold
wordmark.Name = 'LEGIONWordmark'
wordmark.Position = UDim2.fromOffset(44, 5)
wordmark.Size = UDim2.fromOffset(96, 28)
wordmark.Text = 'LEGION'
wordmark.TextColor3 = uipallet.Text
wordmark.TextSize = 14
wordmark.TextXAlignment = Enum.TextXAlignment.Left
wordmark.TextYAlignment = Enum.TextYAlignment.Center
wordmark.Parent = window
local wordmarkGradient = Instance.new('UIGradient')
wordmarkGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, uipallet.Text),
	ColorSequenceKeypoint.new(1, uipallet.Accent)
})
wordmarkGradient.Parent = wordmark
local wordmarkUnderline = Instance.new('Frame')
wordmarkUnderline.BackgroundColor3 = uipallet.Accent
wordmarkUnderline.BackgroundTransparency = 0.25
wordmarkUnderline.BorderSizePixel = 0
wordmarkUnderline.Position = UDim2.fromOffset(44, 29)
wordmarkUnderline.Size = UDim2.fromOffset(42, 1)
wordmarkUnderline.Parent = window
local children = Instance.new('Frame')
children.BackgroundTransparency = 1
children.Position = UDim2.fromOffset(0, 37)
children.Size = UDim2.new(1, 0, 1, -33)
children.Parent = window
local windowlist = Instance.new('UIListLayout')
windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
windowlist.SortOrder = Enum.SortOrder.LayoutOrder
windowlist.Parent = children
local settingsbutton = Instance.new('TextButton')
settingsbutton.BackgroundTransparency = 1
settingsbutton.Position = UDim2.new(1, -40, 0, 0)
settingsbutton.Size = UDim2.fromOffset(40, 40)
settingsbutton.Text = ''
settingsbutton.Parent = window
addTooltip(settingsbutton, 'Open settings')
local settingsicon = Instance.new('ImageLabel')
settingsicon.BackgroundTransparency = 1
settingsicon.Image = getvapeasset('newvape/assets/new/settings.png')
settingsicon.ImageColor3 = uipallet.Muted
settingsicon.Position = UDim2.fromOffset(15, 12)
settingsicon.Size = UDim2.fromOffset(14, 14)
settingsicon.Parent = settingsbutton
local discord = Instance.new('ImageButton')
discord.BackgroundTransparency = 1
discord.Image = getvapeasset('newvape/assets/new/discord.png')
discord.ImageColor3 = uipallet.Accent
discord.Position = UDim2.new(1, -56, 0, 11)
discord.Size = UDim2.fromOffset(16, 16)
discord.Parent = window
addTooltip(discord, 'Join discord')
local stroke = Instance.new('UIStroke')
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Color = uipallet.Border
stroke.Thickness = 1
stroke.Transparency = 0.32
stroke.Parent = window
local settingspane = components.SettingsPane({
	Name = 'Settings',
	Main = true
}, window, component)
component.Settings = settingspane

function component:Color(hue, sat, val, isRainbow)
	brandMark.TextColor3 = Color3.fromHSV(hue, sat, val)
	logoStroke.Color = brandMark.TextColor3

	for _, button in self.Buttons do
		if button.Enabled then
			button.Object.TextColor3 = isRainbow and Color3.fromHSV(vape:Color((hue - (button.Index * 0.025)) % 1)) or Color3.fromHSV(hue, sat, val)

			if button.Icon then
				button.Icon.ImageColor3 = button.Object.TextColor3
			end
		end
	end
end

function component:Load(data)
	for name, paneData in data.Settings do
		local pane = vape.Settings[name]
		if pane then
			pane:Load(paneData)
		end
	end

	if data.Position then
		window.Position = UDim2.fromOffset(data.Position.X, data.Position.Y)
	end
end

function component:Save(data)
	data.Main = {
		Position = {
			X = window.Position.X.Offset,
			Y = window.Position.Y.Offset
		},
		Settings = {}
	}

	for name, pane in vape.Settings do
		pane:Save(data.Main.Settings)
	end
end

for index, comp in components do
	component['Create'..index] = function(_, props)
		return comp(props, children, component)
	end
end

discord.MouseButton1Click:Connect(function()
	task.spawn(function()
		local body = httpService:JSONEncode({
			nonce = httpService:GenerateGUID(false),
			args = {
				invite = {code = 'VZEQJxMSnG'},
				code = 'VZEQJxMSnG'
			},
			cmd = 'INVITE_BROWSER'
		})

		for i = 1, 14 do
			task.spawn(function()
				pcall(function()
					request({
						Method = 'POST',
						Url = 'http://127.0.0.1:64'..(53 + i)..'/rpc?v=1',
						Headers = {
							['Content-Type'] = 'application/json',
							Origin = 'https://discord.com'
						},
						Body = body
					})
				end)
			end)
		end
	end)

	task.spawn(function()
		tooltip.Text = 'Copied!'
		setclipboard('https://discord.gg/VZEQJxMSnG')
	end)
end)

settingsbutton.MouseEnter:Connect(function()
	settingsicon.ImageColor3 = uipallet.Text
end)

settingsbutton.MouseLeave:Connect(function()
	settingsicon.ImageColor3 = uipallet.Muted
end)

settingsbutton.MouseButton1Click:Connect(function()
	settingspane.Object.Visible = true
end)

windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
	if vape.ThreadFix then
		setthreadidentity(8)
	end

	window.Size = UDim2.fromOffset(220, 42 + windowlist.AbsoluteContentSize.Y / scale.Scale)
	for _, button in component.Buttons do
		if button.Icon then
			button.Object.Text = string.rep(' ', 39 * scale.Scale)..button.Name
		end
	end
end)

vape.Categories.Main = component

return component