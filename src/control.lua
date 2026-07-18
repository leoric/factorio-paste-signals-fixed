function handle_paste(event)
	local source = event.source
	local dest = event.destination
	if not (source and source.valid) then return end
	if not (dest and dest.valid) then return end
	if source.type ~= "electric-pole" then return end
	if dest.type ~= "constant-combinator" then return end

	local signals = source.get_signals(defines.wire_connector_id.circuit_red, defines.wire_connector_id.circuit_green)

	local control = dest.get_or_create_control_behavior()
	local section = control.add_section()
	if not (section) then return end

	local filters = {}
	for slot=1,table_size(signals) do
		local s = signals[slot]

		local signalFilter = s.signal
		if not signalFilter.quality then
			signalFilter.quality = 'normal'
		end
		local logisticFilter = {
			value = signalFilter,
			min = s.count,
			max = math.max(s.count, 0),
		}
		filters[slot] = logisticFilter
	end
	section.filters = filters
end

script.on_event(defines.events.on_entity_settings_pasted, handle_paste)
