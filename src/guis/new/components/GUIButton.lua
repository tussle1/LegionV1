local component = {
	Enabled = false,
	Index = getTableSize(api.Buttons),
	Name = props.Name
}

local button = Instance.new('TextButton')
button.AutoButtonColor = false
button.BackgroundColor3 = uipallet.Surface
button.BorderSizePixel = 0
button.FontFace = uipallet.Font
button.Name = props.Name
button.Size = UDim2.fromOffset(220, 40)
button.Text = (props.Icon and string.rep(' ', 39) or props.Window and string.rep(' ', 17) or string.rep(' ', 10))..props.Name
button.TextColor3 = color.Dark(uipallet.Text, 0.16)
button.TextSize = 14
button.TextXAlignment = Enum.TextXAlignment.Left
button.Parent = children
component.Object = button

local activeMarker
if props.Window then
	activeMarker = Instance.new('Frame')
	activeMarker.BackgroundColor3 = uipallet.Accent
	activeMarker.BorderSizePixel = 0
	activeMarker.Name = 'ActiveMarker'
	activeMarker.Position = UDim2.fromOffset(0, 6)
	activeMarker.Size = UDim2.fromOffset(2, 28)
	activeMarker.Visible = false
	activeMarker.Parent = button
	addCorner(activeMarker, UDim.new(1, 0))
end
local icon
if props.Icon then
	icon = Instance.new('ImageLabel')
	icon.BackgroundTransparency = 1
	icon.Image = props.Icon
	icon.ImageColor3 = uipallet.Accent
	icon.Position = UDim2.fromOffset(16, 13)
	icon.Size = props.Size
	icon.Parent = button
	component.Icon = icon
end

if props.Name == 'Profiles' then
	local label = Instance.new('TextLabel')
	label.AnchorPoint = Vector2.new(1, 0)
	label.BackgroundColor3 = uipallet.SurfaceRaised
	label.FontFace = uipallet.Font
	label.Position = UDim2.new(1, -36, 0, 8)
	label.Size = UDim2.fromOffset(53, 24)
	label.Text = 'default'
	label.TextColor3 = uipallet.Muted
	label.TextSize = 12
	label.Parent = button
	addCorner(label)
	vape.ProfileLabel = label
end

local arrow = Instance.new('ImageLabel')
arrow.BackgroundTransparency = 1
arrow.Image = getvapeasset('newvape/assets/new/expandarrow.png')
arrow.ImageColor3 = uipallet.Muted
arrow.Name = 'Arrow'
arrow.Position = UDim2.new(1, -20, 0, 16)
arrow.Size = UDim2.fromOffset(4, 8)
arrow.Parent = button

function component:Destroy()
	button:Destroy()
	button:ClearAllChildren()
end

function component:Toggle()
	if props.Window then
		self.Enabled = not self.Enabled
		activeMarker.Visible = self.Enabled
		tween:Tween(arrow, uipallet.Tween, {
			Position = UDim2.new(1, self.Enabled and -14 or -20, 0, 16)
		})

		button.TextColor3 = self.Enabled and uipallet.Accent or uipallet.Text
		if icon then
			icon.ImageColor3 = self.Enabled and uipallet.Text or uipallet.Accent
		end

		button.BackgroundColor3 = self.Enabled and uipallet.AccentSoft or uipallet.Surface
		props.Window.Visible = self.Enabled
	else
		props.Function()
	end
end

button.MouseEnter:Connect(function()
	if not component.Enabled then
		button.TextColor3 = uipallet.Text
		if icon then
			icon.ImageColor3 = uipallet.Text
		end

		button.BackgroundColor3 = uipallet.SurfaceRaised
	end
end)

button.MouseLeave:Connect(function()
	if not component.Enabled then
		button.TextColor3 = color.Dark(uipallet.Text, 0.16)
		if icon then
			icon.ImageColor3 = uipallet.Accent
		end

		button.BackgroundColor3 = uipallet.Surface
	end
end)

button.MouseButton1Click:Connect(function()
	component:Toggle()
end)

api.Buttons[props.Name] = component

return component