--
-- CreatorTools
--
-- @author  TyKonKet
-- @date 17/01/2017

CTPanelGui = {}
local CTPanelGui_mt = Class(CTPanelGui, ScreenElement);

function CTPanelGui:new(target, custom_mt)
	if custom_mt == nil then
		custom_mt = CTPanelGui_mt;
	end
	local self = ScreenElement:new(target, custom_mt);
	self.returnScreenName = "";
	return self;
end

function CTPanelGui:onOpen()
	CTPanelGui:superClass().onOpen(self);
	FocusManager:setFocus(self.backButton);
	self:setHideHud(CreatorTools.hideHud);
	self:setSelectedPlayerSpeed(CreatorTools.walkingSpeed);
	self.creativeMoneyElement:setDisabled(not g_currentMission.isMasterUser and g_server == nil);
	self.creativeMoneyElement:setIsChecked(CreatorTools.backup.money ~= -1);
end

function CTPanelGui:onClose()
	CTPanelGui:superClass().onClose(self);
end

function CTPanelGui:onClickBack()
	CTPanelGui:superClass().onClickBack(self);
end

function CTPanelGui:onClickOk()
	CTPanelGui:superClass().onClickOk(self);
	CreatorTools:setHud(not self.hideHudElement:getIsChecked());
	CreatorTools:setWalkingSpeed(self.playerSpeedElement:getState());
	CreatorTools:setCreativeMoney(self.creativeMoneyElement:getIsChecked());
	self:onClickBack();
end

function CTPanelGui:setHelpBoxText(text)
	self.ingameMenuHelpBoxText:setText(text);
	self.ingameMenuHelpBox:setVisible(text ~= "");
end

function CTPanelGui:onFocusElement(element)
	if element.toolTip ~= nil then
		self:setHelpBoxText(element.toolTip);
	end
end

function CTPanelGui:onLeaveElement(element)
	self:setHelpBoxText("");
end

function CTPanelGui:onCreateHideHud(element)
	self.hideHudElement = element;
	element.elements[4]:setText(g_i18n:getText("gui_CT_HUD_TEXT"));
	element.toolTip = g_i18n:getText("gui_CT_HUD_TOOLTIP");
end

function CTPanelGui:setHideHud(index)
	self.hideHudElement:setIsChecked(not index);
end

function CTPanelGui:onCreatePlayerSpeed(element)
	self.playerSpeedElement = element;
	element.elements[4]:setText(g_i18n:getText("gui_CT_PLAYER_SPEED_TEXT"));
	element.toolTip = g_i18n:getText("gui_CT_PLAYER_SPEED_TOOLTIP");
	local speeds = {};
	for i=1, CreatorTools.WALKING_SPEEDs_COUNT, 1 do
		 speeds[i] = "x" .. tostring(CreatorTools.WALKING_SPEEDS[i]);
	end
	element:setTexts(speeds);
end

function CTPanelGui:onCreateCreativeMoney(element)
	self.creativeMoneyElement = element;
	element.elements[4]:setText(g_i18n:getText("gui_CT_CREATIVE_MONEY_TEXT"));
	element.toolTip = g_i18n:getText("gui_CT_CREATIVE_MONEY_TOOLTIP");
end

function CTPanelGui:setSelectedPlayerSpeed(index)
	self.playerSpeedElement:setState(index, false);
end