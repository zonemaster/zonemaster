POFILES = $(wildcard *.po)
MOFILES := $(POFILES:.po=.mo)

MSGFMT  = msgfmt --check

%.mo: %.po
	@mkdir -p locale/$*/LC_MESSAGES
	@${MSGFMT} -o locale/$*/LC_MESSAGES/Zonemaster.mo $<
	@echo locale/$*/LC_MESSAGES/Zonemaster.mo

all: ${MOFILES}
	@echo
	@echo Remember to make sure all of the above names are in the
	@echo MANIFEST file, or they will not be installed.
	@echo
