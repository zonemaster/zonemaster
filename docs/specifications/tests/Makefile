DOC=ZonemasterTestSpecifications.md

all: mtp address basic connectivity consistency delegation dnssec nameserver syntax zone

map:
	../../../utils/maprequirement.pl --reqfile ../../requirements/TestRequirements.md \
	--specdir ./ > Report.md
	../../../utils/maptestmessages.pl > TestMessages.md

mtp:
	cat MasterTestPlan.md > $(DOC)

address:
	cat Address-TP/level.md >> $(DOC)
	cat Address-TP/address*.md >> $(DOC)

basic:
	cat Basic-TP/level.md >> $(DOC)
	cat Basic-TP/basic*.md >> $(DOC)

connectivity:
	cat Connectivity-TP/level.md >> $(DOC)
	cat Connectivity-TP/connectivity*.md >> $(DOC)

consistency:
	cat Consistency-TP/level.md >> $(DOC)
	cat Consistency-TP/consistency*.md >> $(DOC)

delegation:
	cat Delegation-TP/level.md >> $(DOC)
	cat Delegation-TP/delegation*.md >> $(DOC)

dnssec:
	cat DNSSEC-TP/level.md >> $(DOC)
	cat DNSSEC-TP/dnssec*.md >> $(DOC)

nameserver:
	cat Nameserver-TP/level.md >> $(DOC)
	cat Nameserver-TP/nameserver*.md >> $(DOC)

syntax:
	cat Syntax-TP/level.md >> $(DOC)
	cat Syntax-TP/syntax*.md >> $(DOC)

zone:
	cat Zone-TP/level.md >> $(DOC)
	cat Zone-TP/zone*.md >> $(DOC)
