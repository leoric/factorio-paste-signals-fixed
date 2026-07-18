-- find all power poles and make them able to paste to all constant combinators
for _,proto in pairs(data.raw["electric-pole"]) do
	if not proto.additional_pastable_entities then
		proto.additional_pastable_entities = {}
	end
	for name in pairs(data.raw["constant-combinator"]) do
		table.insert(proto.additional_pastable_entities, name)
	end
end
