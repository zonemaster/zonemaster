#!/bin/sh

echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info arpa-email-domain.zone09.arpa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info arpa-email-domain.zone09.arpa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-1.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-1.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-2.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-2.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-3.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-3.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-4.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info inconsistent-mx-data-4.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-case-rdata-1.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-case-rdata-1.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-case-rdata-2.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-case-rdata-2.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-ttl-1.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-ttl-1.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-ttl-2.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mixed-ttl-2.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mx-data.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info mx-data.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-arpa.zone09.arpa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-arpa.zone09.arpa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info ."
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info .
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-sld.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-sld.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-tld-zone09"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-mx-tld-zone09
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-response-mx-query-1.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-response-mx-query-1.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-response-mx-query-2.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info no-response-mx-query-2.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info non-auth-mx-response.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info non-auth-mx-response.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-arpa.zone09.arpa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-arpa.zone09.arpa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-non-zero-pref.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-non-zero-pref.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile-NULL-MX-ROOT.zone --level info ."
zonemaster-cli --raw  --test zone09 --hints hintfile-NULL-MX-ROOT.zone --level info .
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-sld.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-sld.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-tld-zone09"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-tld-zone09
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-with-other-mx.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info null-mx-with-other-mx.zone09.xa
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile-ROOT-EMAIL-DOMAIN.zone --level info ."
zonemaster-cli --raw  --test zone09 --hints hintfile-ROOT-EMAIL-DOMAIN.zone --level info .
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info tld-email-domain-zone09"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info tld-email-domain-zone09
echo
echo "$ zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info unexpected-rcode-mx.zone09.xa"
zonemaster-cli --raw  --test zone09 --hints hintfile.zone --level info unexpected-rcode-mx.zone09.xa
echo

