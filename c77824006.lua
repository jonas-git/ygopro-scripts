--Rising of the Winged Dragon
--Scripted by Snrk
function c77824006.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c77824006.condition)
	e1:SetOperation(c77824006.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetCondition(c77824006.drcon)
	e2:SetOperation(c77824006.drop)
	c:RegisterEffect(e2)
end
--draw
function c77824006.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW and eg:IsExists(c77824006.drfil,1,nil) and ep==tp
end
function c77824006.drfil(c)
	return c:IsRace(RACE_DEVINE) and not c:IsPublic()
end
function c77824006.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsLocation(LOCATION_GRAVE) or Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)==0 then return end
	local g=eg:Filter(c77824006.drfil,nil)
	if g:GetCount()~=1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:Select(tp,1,1,nil)
	else sg=g end
	if Duel.ConfirmCards(1-tp,sg)~=0 then
		Duel.ShuffleHand(tp)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
--search
function c77824006.deckfil(c)
	return c77824006.sendfil(c) and Duel.IsExistingMatchingCard(c77824006.addfil,tp,LOCATION_DECK,0,1,c)
end
function c77824006.sendfil(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_DEVINE) and not c:IsSummonableCard() and c:IsAbleToGraveAsCost()
end
function c77824006.addfil(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_DEVINE) and c:IsAbleToHand() and not c:IsSpecialSummonable()
end
function c77824006.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c77824006.deckfil,tp,LOCATION_DECK,0,1,nil)
end
function c77824006.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local gs=Duel.SelectMatchingCard(tp,c77824006.sendfil,tp,LOCATION_DECK,0,1,1,nil)
	if gs:GetCount()>0 and Duel.SendtoGrave(gs,REASON_EFFECT)~=0 and gs:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local ga=Duel.SelectMatchingCard(tp,c77824006.addfil,tp,LOCATION_DECK,0,1,1,nil)
		if ga:GetCount()>0 then
			Duel.SendtoHand(ga,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,ga)
		end
	end
end