--Overlay Wedge
--	by Snrk
local self=c511008032

function self.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(self.condition)
	e1:SetTarget(self.target)
	e1:SetOperation(self.activate)
	c:RegisterEffect(e1)
	if not self.gl_reg then
		self.gl_reg=true
		self[0]=nil
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DETACH_MATERIAL)
		ge1:SetOperation(self.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function self.checkop()
	local cid=Duel.GetCurrentChain()
	if cid>0 then self[0]=Duel.GetChainInfo(cid,CHAININFO_CHAIN_ID) end
end
function self.condition(e,tp,eg,ep,ev,re)
	return Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)==self[0] and re:IsActiveType(TYPE_XYZ) and Duel.IsChainNegatable(ev)
end
function self.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function self.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e2:SetTarget(c50074392.actfilter)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c50074392.actfilter(e,c)
	return c:GetControler()==e:GetHandlerPlayer() and c:IsType(TYPE_MONSTER) and not c:IsAttribute(ATTRIBUTE_WATER)
end













