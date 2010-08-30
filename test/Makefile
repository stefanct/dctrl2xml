SCRIPT  := ../dctrl2xml
SOURCES := $(wildcard *.in)
OBJECTS := $(SOURCES:.in=.xml_) \
           $(SOURCES:.in=.json_)

all: $(OBJECTS)

compare = cmp $(1) $(patsubst %_,%,$(1))

%.xml_: %.in
	$(SCRIPT) --xml -f "$<" | xmllint --format - | \
	  sed 's/dctrl2xml\/[0-9]\+\.[0-9]\+/dctrl2xml/' > "$@"
	$(call compare,$@)

%.json_: %.in
	$(SCRIPT) --json -f "$<" > "$@"
	$(call compare,$@)

stress-test:
	ERRF=`mktemp`; \
	$(SCRIPT) -f /var/lib/dpkg/available 2> $$ERRF | xmllint --format -; \
	apt-cache dumpavail | $(SCRIPT) 2> $$ERRF | xmllint --format -; \
	cat $$ERRF

clean:
	rm -f $(OBJECTS)

.PHONY: clean stress-test
