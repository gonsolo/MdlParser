CITRON		= ../../src/citron
CITRON_SOURCE	= $(CITRON)/src

run: mdl
	./mdl gun_metal.mdl
mdl: $(CITRON_SOURCE)/CitronParser.swift $(CITRON_SOURCE)/CitronLexer.swift mdl.swift main.swift
	swiftc $^ -o $@
mdl.swift: mdl.y
	$(CITRON)/bin/citron $<

e: edit
edit:
	#vi mdl.y
	vi main.swift

