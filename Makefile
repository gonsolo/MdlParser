CITRON		= ../../src/citron
CITRON_SOURCE	= $(CITRON)/src

INPUT		= test.mdl
#INPUT		= gun_metal.mdl

run: mdl
	./mdl $(INPUT)
mdl: $(CITRON_SOURCE)/CitronParser.swift $(CITRON_SOURCE)/CitronLexer.swift mdl.swift main.swift
	swiftc $^ -o $@
mdl.swift: mdl.y
	$(CITRON)/bin/citron $<

e: edit
edit:
	#vi mdl.y
	vi main.swift
ey:
	vi mdl.y
c: clean
clean:
	rm -f mdl mdl.swift
