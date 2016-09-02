
local myname, ns = ...


local function SetTextHelper(self, ...)
	self:SetWidth(40 + self:GetFontString():GetStringWidth())
	return ...
end


local function SetText(self, ...)
	return SetTextHelper(self, self.OrigSetText(self, ...))
end


local function OnEnable(self, ...)
	self.left:Show()
	self.mid:Show()
	self.right:Show()

	self.dis_left:Hide()
	self.dis_mid:Hide()
	self.dis_right:Hide()

	self:GetFontString():SetPoint("CENTER", self, "CENTER", 0, 2)
end


local function OnDisable(self)
	self.left:Hide()
	self.mid:Hide()
	self.right:Hide()

	self.dis_left:Show()
	self.dis_mid:Show()
	self.dis_right:Show()

	self:GetFontString():SetPoint("CENTER", self, "CENTER", 0, -3)
end


function ns.NewBottomTab(parent, template)
	local tab = CreateFrame("Button", nil, parent, template)
	tab:SetSize(10, 32)
	tab:SetFrameLevel(tab:GetFrameLevel() + 4)

	tab.dis_left = tab:CreateTexture(nil, "BACKGROUND")
	tab.dis_left:Hide()
	tab.dis_left:SetSize(20, 35)
	tab.dis_left:SetPoint("TOPLEFT")
	tab.dis_left:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
	tab.dis_left:SetTexCoord(0, 0.15625, 0, 0.546875)

	tab.dis_right = tab:CreateTexture(nil, "BACKGROUND")
	tab.dis_right:Hide()
	tab.dis_right:SetSize(20, 35)
	tab.dis_right:SetPoint("TOPRIGHT")
	tab.dis_right:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
	tab.dis_right:SetTexCoord(0.84375, 1, 0, 0.546875)

	tab.dis_mid = tab:CreateTexture(nil, "BACKGROUND")
	tab.dis_mid:Hide()
	tab.dis_mid:SetSize(88, 35)
	tab.dis_mid:SetPoint("LEFT", tab.dis_left, "RIGHT")
	tab.dis_mid:SetPoint("RIGHT", tab.dis_right, "LEFT")
	tab.dis_mid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
	tab.dis_mid:SetTexCoord(0.15625, 0.84375, 0, 0.546875)

	tab.left = tab:CreateTexture(nil, "BACKGROUND")
	tab.left:SetSize(20, 35)
	tab.left:SetPoint("TOPLEFT", 0, 1)
	tab.left:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab")
	tab.left:SetTexCoord(0, 0.15625, 0, 1)

	tab.right = tab:CreateTexture(nil, "BACKGROUND")
	tab.right:SetSize(20, 35)
	tab.right:SetPoint("TOPRIGHT", 0, 1)
	tab.right:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab")
	tab.right:SetTexCoord(0.84375, 1, 0, 1)

	tab.mid = tab:CreateTexture(nil, "BACKGROUND")
	tab.mid:SetSize(88, 35)
	tab.mid:SetPoint("LEFT", tab.left, "RIGHT")
	tab.mid:SetPoint("RIGHT", tab.right, "LEFT")
	tab.mid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab")
	tab.mid:SetTexCoord(0.15625, 0.84375, 0, 1)

	tab:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-RealHighlight", "ADD")
	local hilite = tab:GetHighlightTexture()
	hilite:ClearAllPoints()
	hilite:SetPoint("TOPLEFT", 3, 5)
	hilite:SetPoint("BOTTOMRIGHT", -3, 0)

	tab:SetDisabledFontObject(GameFontHighlightSmall)
	tab:SetHighlightFontObject(GameFontHighlightSmall)
	tab:SetNormalFontObject(GameFontNormalSmall)

	tab:SetText(" ") -- Set a non-empty string to generate our FontString
	tab:GetFontString():SetPoint("CENTER", tab, "CENTER", 0, 2)

	tab.OrigSetText = tab.SetText
	tab.SetText = SetText

	tab:SetScript("OnEnable", OnEnable)
	tab:SetScript("OnDisable", OnDisable)

	return tab
end
