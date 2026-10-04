uipallet = {
	-- LEGION's Obsidian / Ice palette. Main is kept as the compatibility base
	-- for older component helpers; the named surfaces are used by newer UI.
	Main = Color3.fromRGB(10, 14, 21),
	Surface = Color3.fromRGB(15, 22, 31),
	SurfaceRaised = Color3.fromRGB(21, 31, 43),
	Border = Color3.fromRGB(45, 64, 81),
	Text = Color3.fromRGB(222, 232, 242),
	Muted = Color3.fromRGB(127, 146, 165),
	Accent = Color3.fromRGB(48, 198, 238),
	AccentDeep = Color3.fromRGB(17, 100, 130),
	AccentSoft = Color3.fromRGB(18, 43, 57),
	Danger = Color3.fromRGB(242, 88, 108),
	Warning = Color3.fromRGB(239, 173, 85),
	Success = Color3.fromRGB(78, 211, 164),
	Font = Font.fromEnum(Enum.Font.Gotham),
	FontSemiBold = Font.fromEnum(Enum.Font.Gotham, Enum.FontWeight.SemiBold),
	Tween = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
}

do
	local data = isfile('newvape/profiles/color.txt') and loadJson('newvape/profiles/color.txt')
	if data then
		local function isLegacyColor(value, red, green, blue)
			return type(value) == 'table' and value[1] == red and value[2] == green and value[3] == blue
		end

		-- Preserve actual custom palettes, but don't let the old default Vape
		-- charcoal/gray values undo the new LEGION look on existing installs.
		if data.Main and not isLegacyColor(data.Main, 26, 25, 26) then
			uipallet.Main = Color3.fromRGB(unpack(data.Main))
		end
		if data.Text and not isLegacyColor(data.Text, 200, 200, 200) then
			uipallet.Text = Color3.fromRGB(unpack(data.Text))
		end
		if type(data.Font) == 'string' and not data.Font:lower():find('arial') then
			uipallet.Font = Font.new(
				data.Font:find('rbxasset') and data.Font
				or string.format('rbxasset://fonts/families/%s.json', data.Font)
			)
		end
		uipallet.FontSemiBold = Font.new(uipallet.Font.Family, Enum.FontWeight.SemiBold)
	end

	fontsize.Font = uipallet.Font
end