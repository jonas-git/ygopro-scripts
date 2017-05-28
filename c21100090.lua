Action={}
act=Action

function Action.NormalSummon(c,tp)
	local e1=Effect.CreateEffect(c)
	--e1:SetDescription("Normal Summon")
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetOperation(Action.NOperation(c,tp))
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
end
function Action.NOperation(c,tp)
	Duel.Summon(tp,c,true,nil)
end