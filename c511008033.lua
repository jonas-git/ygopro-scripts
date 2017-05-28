--Double It
--by Snrk

--setcode quiz panel: 0x1213

local self = c511008033
local s_id = 511008033

function self.initial_effect()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EVENT_CHAINING)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCondition(self.repcd)
	e1:SetOperation(self.repop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	c:RegisterEffect(e1)
end
function self.repcd(e,tp,eg,ep,ev,re,r,rp)
	return c:IsSetCard(0x1213) and 
end
function self.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(800)
	c:RegisterEffect(e1)
end