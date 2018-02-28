# Mapping test messages to test module

| Log message identifier                         | Implemented test case          |
|:-----------------------------------------------|:-------------------------------|
| BASIC:DOMAIN_NAME_LABEL_TOO_LONG               | [Basic::basic00]               |
| BASIC:DOMAIN_NAME_TOO_LONG                     | [Basic::basic00]               |
| BASIC:DOMAIN_NAME_ZERO_LENGTH_LABEL            | [Basic::basic00]               |
| BASIC:HAS_PARENT                               | [Basic::basic01]               |
| BASIC:NO_PARENT                                | [Basic::basic01]               |
| BASIC:HAS_NAMESERVERS                          | [Basic::basic02]               |
| BASIC:IPV4_DISABLED                            | [Basic::basic02]               |
| BASIC:IPV4_ENABLED                             | [Basic::basic02]               |
| BASIC:IPV6_DISABLED                            | [Basic::basic02]               |
| BASIC:IPV6_ENABLED                             | [Basic::basic02]               |
| BASIC:NO_GLUE_PREVENTS_NAMESERVER_TESTS        | [Basic::basic02]               |
| BASIC:NS_FAILED                                | [Basic::basic02]               |
| BASIC:NS_NO_RESPONSE                           | [Basic::basic02]               |
| BASIC:A_QUERY_NO_RESPONSES                     | [Basic::basic03]               |
| BASIC:HAS_A_RECORDS                            | [Basic::basic03]               |
| BASIC:IPV4_DISABLED                            | [Basic::basic03]               |
| BASIC:IPV4_ENABLED                             | [Basic::basic03]               |
| BASIC:IPV6_DISABLED                            | [Basic::basic03]               |
| BASIC:IPV6_ENABLED                             | [Basic::basic03]               |
| BASIC:NO_NAMESERVER_PREVENTS_WWW_A_TEST        | [Basic::basic03]               |
| ADDRESS:NAMESERVER_IP_PRIVATE_NETWORK          | [Address::address01]           |
| ADDRESS:NO_IP_PRIVATE_NETWORK                  | [Address::address01]           |
| ADDRESS:NAMESERVERS_IP_WITH_REVERSE            | [Address::address02]           |
| ADDRESS:NAMESERVER_IP_WITHOUT_REVERSE          | [Address::address02]           |
| ADDRESS:NO_RESPONSE_PTR_QUERY                  | [Address::address02]           |
| ADDRESS:NAMESERVER_IP_PTR_MATCH                | [Address::address03]           |
| ADDRESS:NAMESERVER_IP_PTR_MISMATCH             | [Address::address03]           |
| ADDRESS:NAMESERVER_IP_WITHOUT_REVERSE          | [Address::address03]           |
| ADDRESS:NO_RESPONSE_PTR_QUERY                  | [Address::address03]           |
| CONNECTIVITY:IPV4_DISABLED                     | [Connectivity::connectivity01] |
| CONNECTIVITY:IPV6_DISABLED                     | [Connectivity::connectivity01] |
| CONNECTIVITY:NAMESERVER_HAS_UDP_53             | [Connectivity::connectivity01] |
| CONNECTIVITY:NAMESERVER_NO_UDP_53              | [Connectivity::connectivity01] |
| CONNECTIVITY:IPV4_DISABLED                     | [Connectivity::connectivity02] |
| CONNECTIVITY:IPV6_DISABLED                     | [Connectivity::connectivity02] |
| CONNECTIVITY:NAMESERVER_HAS_TCP_53             | [Connectivity::connectivity02] |
| CONNECTIVITY:NAMESERVER_NO_TCP_53              | [Connectivity::connectivity02] |
| CONNECTIVITY:ASN_INFOS_ANNOUNCE_BY             | [Connectivity::connectivity03] |
| CONNECTIVITY:ASN_INFOS_ANNOUNCE_IN             | [Connectivity::connectivity03] |
| CONNECTIVITY:ASN_INFOS_RAW                     | [Connectivity::connectivity03] |
| CONNECTIVITY:IPV4_ASN                          | [Connectivity::connectivity03] |
| CONNECTIVITY:IPV4_DISABLED                     | [Connectivity::connectivity03] |
| CONNECTIVITY:IPV6_ASN                          | [Connectivity::connectivity03] |
| CONNECTIVITY:IPV6_DISABLED                     | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_IPV4_NO_AS            | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_IPV4_WITH_MULTIPLE_AS | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_IPV4_WITH_UNIQ_AS     | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_IPV6_NO_AS            | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_IPV6_WITH_MULTIPLE_AS | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_IPV6_WITH_UNIQ_AS     | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_NO_AS                 | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_WITH_MULTIPLE_AS      | [Connectivity::connectivity03] |
| CONNECTIVITY:NAMESERVERS_WITH_UNIQ_AS          | [Connectivity::connectivity03] |
| CONSISTENCY:IPV4_DISABLED                      | [Consistency::consistency01]   |
| CONSISTENCY:IPV6_DISABLED                      | [Consistency::consistency01]   |
| CONSISTENCY:MULTIPLE_SOA_SERIALS               | [Consistency::consistency01]   |
| CONSISTENCY:NO_RESPONSE                        | [Consistency::consistency01]   |
| CONSISTENCY:NO_RESPONSE_SOA_QUERY              | [Consistency::consistency01]   |
| CONSISTENCY:ONE_SOA_SERIAL                     | [Consistency::consistency01]   |
| CONSISTENCY:SOA_SERIAL                         | [Consistency::consistency01]   |
| CONSISTENCY:SOA_SERIAL_VARIATION               | [Consistency::consistency01]   |
| CONSISTENCY:IPV4_DISABLED                      | [Consistency::consistency02]   |
| CONSISTENCY:IPV6_DISABLED                      | [Consistency::consistency02]   |
| CONSISTENCY:MULTIPLE_SOA_RNAMES                | [Consistency::consistency02]   |
| CONSISTENCY:NO_RESPONSE                        | [Consistency::consistency02]   |
| CONSISTENCY:NO_RESPONSE_SOA_QUERY              | [Consistency::consistency02]   |
| CONSISTENCY:ONE_SOA_RNAME                      | [Consistency::consistency02]   |
| CONSISTENCY:SOA_RNAME                          | [Consistency::consistency02]   |
| CONSISTENCY:IPV4_DISABLED                      | [Consistency::consistency03]   |
| CONSISTENCY:IPV6_DISABLED                      | [Consistency::consistency03]   |
| CONSISTENCY:MULTIPLE_SOA_TIME_PARAMETER_SET    | [Consistency::consistency03]   |
| CONSISTENCY:NO_RESPONSE                        | [Consistency::consistency03]   |
| CONSISTENCY:NO_RESPONSE_SOA_QUERY              | [Consistency::consistency03]   |
| CONSISTENCY:ONE_SOA_TIME_PARAMETER_SET         | [Consistency::consistency03]   |
| CONSISTENCY:SOA_TIME_PARAMETER_SET             | [Consistency::consistency03]   |
| CONSISTENCY:IPV4_DISABLED                      | [Consistency::consistency04]   |
| CONSISTENCY:IPV6_DISABLED                      | [Consistency::consistency04]   |
| CONSISTENCY:MULTIPLE_NS_SET                    | [Consistency::consistency04]   |
| CONSISTENCY:NO_RESPONSE                        | [Consistency::consistency04]   |
| CONSISTENCY:NO_RESPONSE_NS_QUERY               | [Consistency::consistency04]   |
| CONSISTENCY:NS_SET                             | [Consistency::consistency04]   |
| CONSISTENCY:ONE_NS_SET                         | [Consistency::consistency04]   |
| CONSISTENCY:ADDRESSES_MATCH                    | [Consistency::consistency05]   |
| CONSISTENCY:EXTRA_ADDRESS_CHILD                | [Consistency::consistency05]   |
| CONSISTENCY:EXTRA_ADDRESS_PARENT               | [Consistency::consistency05]   |
| CONSISTENCY:TOTAL_ADDRESS_MISMATCH             | [Consistency::consistency05]   |
| DELEGATION:ENOUGH_NS                           | [Delegation::delegation01]     |
| DELEGATION:ENOUGH_NS_GLUE                      | [Delegation::delegation01]     |
| DELEGATION:NOT_ENOUGH_NS                       | [Delegation::delegation01]     |
| DELEGATION:NOT_ENOUGH_NS_GLUE                  | [Delegation::delegation01]     |
| DELEGATION:SAME_IP_ADDRESS                     | [Delegation::delegation02]     |
| DELEGATION:REFERRAL_SIZE_LARGE                 | [Delegation::delegation03]     |
| DELEGATION:REFERRAL_SIZE_OK                    | [Delegation::delegation03]     |
| DELEGATION:ARE_AUTHORITATIVE                   | [Delegation::delegation04]     |
| DELEGATION:IPV4_DISABLED                       | [Delegation::delegation04]     |
| DELEGATION:IPV6_DISABLED                       | [Delegation::delegation04]     |
| DELEGATION:IS_NOT_AUTHORITATIVE                | [Delegation::delegation04]     |
| DELEGATION:NS_RR_IS_CNAME                      | [Delegation::delegation05]     |
| DELEGATION:IPV4_DISABLED                       | [Delegation::delegation06]     |
| DELEGATION:IPV6_DISABLED                       | [Delegation::delegation06]     |
| DELEGATION:SOA_NOT_EXISTS                      | [Delegation::delegation06]     |
| DELEGATION:EXTRA_NAME_CHILD                    | [Delegation::delegation07]     |
| DELEGATION:EXTRA_NAME_PARENT                   | [Delegation::delegation07]     |
| DELEGATION:NAMES_MATCH                         | [Delegation::delegation07]     |
| DELEGATION:TOTAL_NAME_MISMATCH                 | [Delegation::delegation07]     |
| DNSSEC:DS_DIGTYPE_NOT_OK                       | [DNSSEC::dnssec01]             |
| DNSSEC:DS_DIGTYPE_OK                           | [DNSSEC::dnssec01]             |
| DNSSEC:NO_DS                                   | [DNSSEC::dnssec01]             |
| DNSSEC:COMMON_KEYTAGS                          | [DNSSEC::dnssec02]             |
| DNSSEC:DS_DOES_NOT_MATCH_DNSKEY                | [DNSSEC::dnssec02]             |
| DNSSEC:DS_FOUND                                | [DNSSEC::dnssec02]             |
| DNSSEC:DS_MATCHES_DNSKEY                       | [DNSSEC::dnssec02]             |
| DNSSEC:DS_MATCH_FOUND                          | [DNSSEC::dnssec02]             |
| DNSSEC:DS_MATCH_NOT_FOUND                      | [DNSSEC::dnssec02]             |
| DNSSEC:DS_RFC4509_NOT_VALID                    | [DNSSEC::dnssec02]             |
| DNSSEC:NO_COMMON_KEYTAGS                       | [DNSSEC::dnssec02]             |
| DNSSEC:NO_DNSKEY                               | [DNSSEC::dnssec02]             |
| DNSSEC:NO_DS                                   | [DNSSEC::dnssec02]             |
| DNSSEC:ITERATIONS_OK                           | [DNSSEC::dnssec03]             |
| DNSSEC:MANY_ITERATIONS                         | [DNSSEC::dnssec03]             |
| DNSSEC:NO_DNSKEY                               | [DNSSEC::dnssec03]             |
| DNSSEC:NO_NSEC3PARAM                           | [DNSSEC::dnssec03]             |
| DNSSEC:TOO_MANY_ITERATIONS                     | [DNSSEC::dnssec03]             |
| DNSSEC:DURATION_LONG                           | [DNSSEC::dnssec04]             |
| DNSSEC:DURATION_OK                             | [DNSSEC::dnssec04]             |
| DNSSEC:REMAINING_LONG                          | [DNSSEC::dnssec04]             |
| DNSSEC:REMAINING_SHORT                         | [DNSSEC::dnssec04]             |
| DNSSEC:RRSIG_EXPIRATION                        | [DNSSEC::dnssec04]             |
| DNSSEC:RRSIG_EXPIRED                           | [DNSSEC::dnssec04]             |
| DNSSEC:ALGORITHM_DEPRECATED                    | [DNSSEC::dnssec05]             |
| DNSSEC:ALGORITHM_OK                            | [DNSSEC::dnssec05]             |
| DNSSEC:ALGORITHM_PRIVATE                       | [DNSSEC::dnssec05]             |
| DNSSEC:ALGORITHM_RESERVED                      | [DNSSEC::dnssec05]             |
| DNSSEC:ALGORITHM_UNASSIGNED                    | [DNSSEC::dnssec05]             |
| DNSSEC:ALGORITHM_UNKNOWN                       | [DNSSEC::dnssec05]             |
| DNSSEC:KEY_DETAILS                             | [DNSSEC::dnssec05]             |
| DNSSEC:EXTRA_PROCESSING_BROKEN                 | [DNSSEC::dnssec06]             |
| DNSSEC:EXTRA_PROCESSING_OK                     | [DNSSEC::dnssec06]             |
| DNSSEC:ADDITIONAL_DNSKEY_SKIPPED               | [DNSSEC::dnssec07]             |
| DNSSEC:DNSKEY_AND_DS                           | [DNSSEC::dnssec07]             |
| DNSSEC:DNSKEY_BUT_NOT_DS                       | [DNSSEC::dnssec07]             |
| DNSSEC:DS_BUT_NOT_DNSKEY                       | [DNSSEC::dnssec07]             |
| DNSSEC:NEITHER_DNSKEY_NOR_DS                   | [DNSSEC::dnssec07]             |
| DNSSEC:DNSKEY_NOT_SIGNED                       | [DNSSEC::dnssec08]             |
| DNSSEC:DNSKEY_SIGNATURE_NOT_OK                 | [DNSSEC::dnssec08]             |
| DNSSEC:DNSKEY_SIGNATURE_OK                     | [DNSSEC::dnssec08]             |
| DNSSEC:DNSKEY_SIGNED                           | [DNSSEC::dnssec08]             |
| DNSSEC:NO_KEYS_OR_NO_SIGS                      | [DNSSEC::dnssec08]             |
| DNSSEC:NO_KEYS_OR_NO_SIGS_OR_NO_SOA            | [DNSSEC::dnssec09]             |
| DNSSEC:SOA_NOT_SIGNED                          | [DNSSEC::dnssec09]             |
| DNSSEC:SOA_SIGNATURE_NOT_OK                    | [DNSSEC::dnssec09]             |
| DNSSEC:SOA_SIGNATURE_OK                        | [DNSSEC::dnssec09]             |
| DNSSEC:SOA_SIGNED                              | [DNSSEC::dnssec09]             |
| DNSSEC:HAS_NSEC                                | [DNSSEC::dnssec10]             |
| DNSSEC:HAS_NSEC3                               | [DNSSEC::dnssec10]             |
| DNSSEC:HAS_NSEC3_OPTOUT                        | [DNSSEC::dnssec10]             |
| DNSSEC:INVALID_NAME_RCODE                      | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC3_COVERS                            | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC3_COVERS_NOT                        | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC3_NOT_SIGNED                        | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC3_SIGNED                            | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC3_SIG_VERIFY_ERROR                  | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC_COVERS                             | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC_COVERS_NOT                         | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC_NOT_SIGNED                         | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC_SIGNED                             | [DNSSEC::dnssec10]             |
| DNSSEC:NSEC_SIG_VERIFY_ERROR                   | [DNSSEC::dnssec10]             |
| DNSSEC:DELEGATION_NOT_SIGNED                   | [DNSSEC::dnssec11]             |
| DNSSEC:DELEGATION_SIGNED                       | [DNSSEC::dnssec11]             |
| EXAMPLE:EXAMPLE_TAG                            | [Example::placeholder]         |
| NAMESERVER:IS_A_RECURSOR                       | [Nameserver::nameserver01]     |
| NAMESERVER:NO_RECURSOR                         | [Nameserver::nameserver01]     |
| NAMESERVER:RECURSIVITY_UNDEF                   | [Nameserver::nameserver01]     |
| NAMESERVER:EDNS0_BAD_ANSWER                    | [Nameserver::nameserver02]     |
| NAMESERVER:EDNS0_BAD_QUERY                     | [Nameserver::nameserver02]     |
| NAMESERVER:EDNS0_SUPPORT                       | [Nameserver::nameserver02]     |
| NAMESERVER:AXFR_AVAILABLE                      | [Nameserver::nameserver03]     |
| NAMESERVER:AXFR_FAILURE                        | [Nameserver::nameserver03]     |
| NAMESERVER:DIFFERENT_SOURCE_IP                 | [Nameserver::nameserver04]     |
| NAMESERVER:SAME_SOURCE_IP                      | [Nameserver::nameserver04]     |
| NAMESERVER:ANSWER_BAD_RCODE                    | [Nameserver::nameserver05]     |
| NAMESERVER:IPV4_DISABLED                       | [Nameserver::nameserver05]     |
| NAMESERVER:IPV6_DISABLED                       | [Nameserver::nameserver05]     |
| NAMESERVER:QUERY_DROPPED                       | [Nameserver::nameserver05]     |
| NAMESERVER:CAN_BE_RESOLVED                     | [Nameserver::nameserver06]     |
| NAMESERVER:CAN_NOT_BE_RESOLVED                 | [Nameserver::nameserver06]     |
| NAMESERVER:NO_RESOLUTION                       | [Nameserver::nameserver06]     |
| NAMESERVER:NO_UPWARD_REFERRAL                  | [Nameserver::nameserver07]     |
| NAMESERVER:UPWARD_REFERRAL                     | [Nameserver::nameserver07]     |
| NAMESERVER:UPWARD_REFERRAL_IRRELEVANT          | [Nameserver::nameserver07]     |
| NAMESERVER:QNAME_CASE_INSENSITIVE              | [Nameserver::nameserver08]     |
| NAMESERVER:QNAME_CASE_SENSITIVE                | [Nameserver::nameserver08]     |
| NAMESERVER:CASE_QUERIES_RESULTS_DIFFER         | [Nameserver::nameserver09]     |
| NAMESERVER:CASE_QUERIES_RESULTS_OK             | [Nameserver::nameserver09]     |
| NAMESERVER:CASE_QUERY_DIFFERENT_ANSWER         | [Nameserver::nameserver09]     |
| NAMESERVER:CASE_QUERY_DIFFERENT_RC             | [Nameserver::nameserver09]     |
| NAMESERVER:CASE_QUERY_NO_ANSWER                | [Nameserver::nameserver09]     |
| NAMESERVER:CASE_QUERY_SAME_ANSWER              | [Nameserver::nameserver09]     |
| NAMESERVER:CASE_QUERY_SAME_RC                  | [Nameserver::nameserver09]     |
| SYNTAX:NON_ALLOWED_CHARS                       | [Syntax::syntax01]             |
| SYNTAX:ONLY_ALLOWED_CHARS                      | [Syntax::syntax01]             |
| SYNTAX:INITIAL_HYPHEN                          | [Syntax::syntax02]             |
| SYNTAX:NO_ENDING_HYPHENS                       | [Syntax::syntax02]             |
| SYNTAX:TERMINAL_HYPHEN                         | [Syntax::syntax02]             |
| SYNTAX:DISCOURAGED_DOUBLE_DASH                 | [Syntax::syntax03]             |
| SYNTAX:NO_DOUBLE_DASH                          | [Syntax::syntax03]             |
| SYNTAX:NAMESERVER_DISCOURAGED_DOUBLE_DASH      | [Syntax::syntax04]             |
| SYNTAX:NAMESERVER_NON_ALLOWED_CHARS            | [Syntax::syntax04]             |
| SYNTAX:NAMESERVER_NUMERIC_TLD                  | [Syntax::syntax04]             |
| SYNTAX:NAMESERVER_SYNTAX_OK                    | [Syntax::syntax04]             |
| SYNTAX:NO_RESPONSE_SOA_QUERY                   | [Syntax::syntax05]             |
| SYNTAX:RNAME_MISUSED_AT_SIGN                   | [Syntax::syntax05]             |
| SYNTAX:RNAME_NO_AT_SIGN                        | [Syntax::syntax05]             |
| SYNTAX:NO_RESPONSE_SOA_QUERY                   | [Syntax::syntax06]             |
| SYNTAX:RNAME_RFC822_INVALID                    | [Syntax::syntax06]             |
| SYNTAX:MNAME_DISCOURAGED_DOUBLE_DASH           | [Syntax::syntax07]             |
| SYNTAX:MNAME_NON_ALLOWED_CHARS                 | [Syntax::syntax07]             |
| SYNTAX:MNAME_NUMERIC_TLD                       | [Syntax::syntax07]             |
| SYNTAX:MNAME_SYNTAX_OK                         | [Syntax::syntax07]             |
| SYNTAX:NO_RESPONSE_SOA_QUERY                   | [Syntax::syntax07]             |
| SYNTAX:MX_DISCOURAGED_DOUBLE_DASH              | [Syntax::syntax08]             |
| SYNTAX:MX_NON_ALLOWED_CHARS                    | [Syntax::syntax08]             |
| SYNTAX:MX_NUMERIC_TLD                          | [Syntax::syntax08]             |
| SYNTAX:MX_SYNTAX_OK                            | [Syntax::syntax08]             |
| SYNTAX:NO_RESPONSE_MX_QUERY                    | [Syntax::syntax08]             |
| ZONE:MNAME_IS_AUTHORITATIVE                    | [Zone::zone01]                 |
| ZONE:MNAME_NOT_AUTHORITATIVE                   | [Zone::zone01]                 |
| ZONE:MNAME_NOT_IN_GLUE                         | [Zone::zone01]                 |
| ZONE:MNAME_NO_RESPONSE                         | [Zone::zone01]                 |
| ZONE:MNAME_RECORD_DOES_NOT_EXIST               | [Zone::zone01]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone01]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone02]                 |
| ZONE:REFRESH_MINIMUM_VALUE_LOWER               | [Zone::zone02]                 |
| ZONE:REFRESH_MINIMUM_VALUE_OK                  | [Zone::zone02]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone03]                 |
| ZONE:REFRESH_HIGHER_THAN_RETRY                 | [Zone::zone03]                 |
| ZONE:REFRESH_LOWER_THAN_RETRY                  | [Zone::zone03]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone04]                 |
| ZONE:RETRY_MINIMUM_VALUE_LOWER                 | [Zone::zone04]                 |
| ZONE:RETRY_MINIMUM_VALUE_OK                    | [Zone::zone04]                 |
| ZONE:EXPIRE_LOWER_THAN_REFRESH                 | [Zone::zone05]                 |
| ZONE:EXPIRE_MINIMUM_VALUE_LOWER                | [Zone::zone05]                 |
| ZONE:EXPIRE_MINIMUM_VALUE_OK                   | [Zone::zone05]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone05]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone06]                 |
| ZONE:SOA_DEFAULT_TTL_MAXIMUM_VALUE_HIGHER      | [Zone::zone06]                 |
| ZONE:SOA_DEFAULT_TTL_MAXIMUM_VALUE_LOWER       | [Zone::zone06]                 |
| ZONE:SOA_DEFAULT_TTL_MAXIMUM_VALUE_OK          | [Zone::zone06]                 |
| ZONE:MNAME_HAS_NO_ADDRESS                      | [Zone::zone07]                 |
| ZONE:MNAME_IS_CNAME                            | [Zone::zone07]                 |
| ZONE:MNAME_IS_NOT_CNAME                        | [Zone::zone07]                 |
| ZONE:NO_RESPONSE_SOA_QUERY                     | [Zone::zone07]                 |
| ZONE:MX_RECORD_IS_CNAME                        | [Zone::zone08]                 |
| ZONE:MX_RECORD_IS_NOT_CNAME                    | [Zone::zone08]                 |
| ZONE:NO_RESPONSE_MX_QUERY                      | [Zone::zone08]                 |
| ZONE:MX_RECORD_EXISTS                          | [Zone::zone09]                 |
| ZONE:NO_MX_RECORD                              | [Zone::zone09]                 |
| ZONE:NO_RESPONSE_MX_QUERY                      | [Zone::zone09]                 |

[Address::address01]: Address-TP/address01.md
[Address::address02]: Address-TP/address02.md
[Address::address03]: Address-TP/address03.md
[Basic::basic00]: Basic-TP/basic00.md
[Basic::basic01]: Basic-TP/basic01.md
[Basic::basic02]: Basic-TP/basic02.md
[Basic::basic03]: Basic-TP/basic03.md
[Connectivity::connectivity01]: Connectivity-TP/connectivity01.md
[Connectivity::connectivity02]: Connectivity-TP/connectivity02.md
[Connectivity::connectivity03]: Connectivity-TP/connectivity03.md
[Consistency::consistency01]: Consistency-TP/consistency01.md
[Consistency::consistency02]: Consistency-TP/consistency02.md
[Consistency::consistency03]: Consistency-TP/consistency03.md
[Consistency::consistency04]: Consistency-TP/consistency04.md
[Consistency::consistency05]: Consistency-TP/consistency05.md
[DNSSEC::dnssec01]: DNSSEC-TP/dnssec01.md
[DNSSEC::dnssec02]: DNSSEC-TP/dnssec02.md
[DNSSEC::dnssec03]: DNSSEC-TP/dnssec03.md
[DNSSEC::dnssec04]: DNSSEC-TP/dnssec04.md
[DNSSEC::dnssec05]: DNSSEC-TP/dnssec05.md
[DNSSEC::dnssec06]: DNSSEC-TP/dnssec06.md
[DNSSEC::dnssec07]: DNSSEC-TP/dnssec07.md
[DNSSEC::dnssec08]: DNSSEC-TP/dnssec08.md
[DNSSEC::dnssec09]: DNSSEC-TP/dnssec09.md
[DNSSEC::dnssec10]: DNSSEC-TP/dnssec10.md
[DNSSEC::dnssec11]: DNSSEC-TP/dnssec11.md
[Delegation::delegation01]: Delegation-TP/delegation01.md
[Delegation::delegation02]: Delegation-TP/delegation02.md
[Delegation::delegation03]: Delegation-TP/delegation03.md
[Delegation::delegation04]: Delegation-TP/delegation04.md
[Delegation::delegation05]: Delegation-TP/delegation05.md
[Delegation::delegation06]: Delegation-TP/delegation06.md
[Delegation::delegation07]: Delegation-TP/delegation07.md
[Example::placeholder]: Example-TP/placeholder.md
[Nameserver::nameserver01]: Nameserver-TP/nameserver01.md
[Nameserver::nameserver02]: Nameserver-TP/nameserver02.md
[Nameserver::nameserver03]: Nameserver-TP/nameserver03.md
[Nameserver::nameserver04]: Nameserver-TP/nameserver04.md
[Nameserver::nameserver05]: Nameserver-TP/nameserver05.md
[Nameserver::nameserver06]: Nameserver-TP/nameserver06.md
[Nameserver::nameserver07]: Nameserver-TP/nameserver07.md
[Nameserver::nameserver08]: Nameserver-TP/nameserver08.md
[Nameserver::nameserver09]: Nameserver-TP/nameserver09.md
[Syntax::syntax01]: Syntax-TP/syntax01.md
[Syntax::syntax02]: Syntax-TP/syntax02.md
[Syntax::syntax03]: Syntax-TP/syntax03.md
[Syntax::syntax04]: Syntax-TP/syntax04.md
[Syntax::syntax05]: Syntax-TP/syntax05.md
[Syntax::syntax06]: Syntax-TP/syntax06.md
[Syntax::syntax07]: Syntax-TP/syntax07.md
[Syntax::syntax08]: Syntax-TP/syntax08.md
[Zone::zone01]: Zone-TP/zone01.md
[Zone::zone02]: Zone-TP/zone02.md
[Zone::zone03]: Zone-TP/zone03.md
[Zone::zone04]: Zone-TP/zone04.md
[Zone::zone05]: Zone-TP/zone05.md
[Zone::zone06]: Zone-TP/zone06.md
[Zone::zone07]: Zone-TP/zone07.md
[Zone::zone08]: Zone-TP/zone08.md
[Zone::zone09]: Zone-TP/zone09.md
