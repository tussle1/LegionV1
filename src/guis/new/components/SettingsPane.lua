local component = {
	Buttons = {},
	Options = {},
	Parent = api.Parent or children,
	Type = 'SettingsPane'
}

local pane = Instance.new('TextButton')
pane.AutoButtonColor = false
pane.BackgroundColor3 = props.Main and uipallet.Surface or uipallet.SurfaceRaised
pane.Size = UDim2.fromScale(1, 1)
pane.Text = ''
pane.Visible = false
pane.Parent = component.Parent
local title = Instance.new('TextLabel')
title.BackgroundTransparency = 1
title.FontFace = uipallet.FontSemiBold
title.Name = 'Title'
title.Size = UDim2.new(1, -36, 0, 20)
title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 11)
title.Text = props.Name
title.TextColor3 = uipallet.Text
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = pane
local close = addCloseButton(pane, true)
local back = Instance.new('ImageButton')
back.BackgroundTransparency = 1
back.Image = getvapeasset('newvape/assets/new/backmini.png')
back.ImageColor3 = color.Light(uipallet.Main, 0.37)
back.Position = UDim2.fromOffset(12, 14)
back.Size = UDim2.fromOffset(14, 14)
back.Parent = pane
addCorner(pane)
local paneStroke = Instance.new('UIStroke')
paneStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
paneStroke.Color = uipallet.Border
paneStroke.Thickness = 1
paneStroke.Transparency = 0.32
paneStroke.Parent = pane
local settingschildren = Instance.new('Frame')
settingschildren.BackgroundColor3 = uipallet.Surface
settingschildren.BorderSizePixel = 0
settingschildren.Name = 'Children'
settingschildren.Position = UDim2.fromOffset(0, 41)
settingschildren.Size = UDim2.new(1, 0, 1, -57)
settingschildren.Parent = pane
local divider = Instance.new('Frame')
divider.BackgroundColor3 = uipallet.Border
divider.BackgroundTransparency = 0.45
divider.BorderSizePixel = 0
divider.Name = 'Divider'
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Parent = settingschildren
local listlayout = Instance.new('UIListLayout')
listlayout.SortOrder = Enum.SortOrder.LayoutOrder
listlayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listlayout.Parent = settingschildren
if props.Main then
	local versionlabel = Instance.new('TextLabel')
	versionlabel.BackgroundTransparency = 1
	versionlabel.FontFace = uipallet.FontSemiBold
	versionlabel.Name = 'Version'
	versionlabel.Position = UDim2.new(0, 0, 1, -16)
	versionlabel.Size = UDim2.new(1, 0, 0, 16)
	versionlabel.Text = 'LEGION | v'..vape.Version..' | '..(
		isfile('newvape/profiles/commit.txt') and readfile('newvape/profiles/commit.txt'):sub(1, 6) or ''
	)..' '
	versionlabel.TextColor3 = uipallet.Muted
	versionlabel.TextSize = 10
	versionlabel.TextXAlignment = Enum.TextXAlignment.Right
	versionlabel.Parent = pane
else
	api:CreateGUIButton({
		Name = props.Name,
		Function = function()
			pane.Visible = true
		end
	})
end

function component:Load(data)
	vape:LoadOptions(self, data)
end

function component:Save(data)
	data[props.Name] = vape:SaveOptions(self)
end

for index, comp in components do
	component['Create'..index] = function(_, props)
		return comp(props, settingschildren, component)
	end
end

back.MouseEnter:Connect(function()
	back.ImageColor3 = uipallet.Text
end)

back.MouseLeave:Connect(function()
	back.ImageColor3 = color.Light(uipallet.Main, 0.37)
end)

back.MouseButton1Click:Connect(function()
	pane.Visible = false
end)

close.MouseButton1Click:Connect(function()
	pane.Visible = false
end)

listlayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
	if vape.ThreadFix then
		setthreadidentity(8)
	end

	pane.Size = UDim2.new(1, 0, 0, math.max(45 + listlayout.AbsoluteContentSize.Y, component.Parent.AbsoluteSize.Y) / scale.Scale)
end)

component.Object = pane
vape.Settings[props.Name] = component

return component