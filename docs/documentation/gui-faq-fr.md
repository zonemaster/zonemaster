Zonemaster
==========

1. Zonemaster, c'est quoi ?
2. Qui se cache derrière Zonemaster ?
3. Qu'est-ce que Zonemaster peut faire pour moi ?
4. Zonemaster indique des "Erreurs"/"Avertissements" sur ma zone, qu'est ce que cela signifie ?
5. Comment Zonemaster peut décider ce qui est correct de ce qui ne l'est pas ?
6. Est-ce que Zonemaster supporte IPv6 ?
7. Est-ce que Zonemaster supporte DNSSEC ? 
8. Qu'est ce qui fait que Zonemaster est différent des outils existants ?
9. Est-ce que Zonemaster peut analyser des zones qui ne sont ni en .fr, ni en .se ?
10. Zonemaster et confidentialité
11. Comment se fait-il que je ne puisse pas tester mon nom de domaine ?
12. Quels genres de requêtes Zonemaster génère t-il ?
13. C'est quoi un test sur un domaine non délégué ?
14. Comment tester une zone "reverse" avec Zonemaster ?

Zonemaster
----------

#### 1. Zonemaster c'est quoi ?  

Zonemaster est un outil qui a été créé dans le but d'aider au diagnostique,
de mesurer et aussi permettre à ses utilisateurs de mieux comprendre le
fonctionnement du DNS (Domain Name System). Il est principalement constitué
de 3 éléments qui sont:

 1. Un moteur de tests qui contient tout le code nécessaire aux traitements
    à réaliser lors de l'analyse d'une zone.
 2. Une interface en ligne de commande (CLI) plus particulièrement dédiée
    aux utilisateurs les plus expérimentés.
 3. Une interface Web permettant un accès rapide à l'outil.

Lorsqu'un nom de domaine (et conséquemment la zone à laquelle il fait 
référence) est soumis à Zonemaster, ce dernier va réaliser une analyse 
complète et parcourir l'arborescence des noms de domaine en partant de la 
racine (.) jusqu'aux serveurs de noms contenant les informations pour la 
zone correspondante. Ceci afin de détecter toute anomalie indiquant une 
non conformité ou faille qui pourrait conduire à une mauvaise qualité du
service. Ce qui inclut, des tests de connectivité, de validité des adresses
IP, de contrôle de validité des signatures DNSSEC...

L'ensemble des tests réalisés par Zonemaster est décrit au sein du document
[Test Requirements document](https://github.com/dotse/zonemaster/blob/master/docs/requirements/TestRequirements.md).

#### 2. Qui se cache derrière Zonemaster ?

Zonemaster est un projet conjoint entre l'Afnic (multi-registre français de 
ccTLDs .fr, .re, .pm, .tf, .wf, .yt et de gTLDs .paris, ...) d'une part et
le .SE (registre suédois des ccTLDs .se et .nu) d'autre part.

#### 3. Qu'est-ce que Zonemaster peut faire pour moi ? 

Zonemaster a été créé pour un public de techniciens, ou tout du moins pour
les personnes s'intéressant à la manière dont le DNS fonctionne. Il peut
par exemple être utilisé pour montrer aux responsables techniques de votre 
nom de domaine, qu'un problème de configuration est en cours en leur
fournissant le lien généré par Zonemaster qui se trouve à la fin de chaque 
analyse. Ainsi, si vous avez demandé une analyse et que vous souhaitez
montrer à quelqu'un le résultat de celle-ci vous pouvez juste copier le lien
fourni sur la page des résultats de tests. Le lien suivant, par exemple, 
renvoie sur les résultats de la dernière analyse de "afnic.fr":

#### 4. Zonemaster indique des "Erreurs"/"Avertissements" sur ma zone, qu'est ce que cela signifie ? 

Bien évidemment, cela dépend du type des tests qui ont échoué lors de l'analyse
de la zone. Dans la plupart des cas, vous pouvez cliquer sur le message d'erreur
ou d'avertissement pour obtenir plus de détails sur le problème qui a été détecté.

#### 5. Comment Zonemaster peut décider ce qui est correct de ce qui ne l'est pas ?  

Personne ne peut donner de jugement définitif quand à la bonne configuration
d'une zone (même si certaines erreurs font toutefois consensus). Il est très 
important de comprendre que les équipe de l'Afnic et du .SE derrière la 
conception de Zonemaster ne prétendent pas détenir la connaissance absolue
sur tous les aspects vérifiés au cours de l'analyse d'une zone. Parfois
des règles font débat entre pays, mais aussi plus localement. Nous avons
fait notre possible pour proposer une politique par défaut pour qualifier
les erreurs, au sein du projet. Nous nous sommes assurés de réaliser un bon
compromis entre des erreurs réellement dangereuses et celles qui peuvent
être considérées comme des conseils de bonne pratique non critiques pour  
le bon fonctionnement de la zone testée.

Un des avantages de Zonemaster est qu'il est possible d'utiliser d'autres
politiques que celles déjà existantes (en utilisant un fichier que l'on
peut écrire pour ses propres besoins).

Mais, avec les technonologies évolutives, comme le DNS, ce qui est aujourd'hui
un simple avertissement, peut devenir demain une faille de sécurité grave. Si
vous considérez que nous avons fait une erreur de jugement pour qualifier une
erreur, n'hésitez pas à nous en faire part en envoyant un Email à l'adresse
zonemaster-devel@lists.iis.se avec le lien sur le test réalisé et un commentaire
indiquant ce que vous pensez être incorrect dans notre diagnostique. (Si vous
ne savez pas quel lien envoyer, consulter la réponse à la question "Qu'est-ce 
que Zonemaster peut faire pour moi ?" qui se trouve dans cette FAQ)

#### 6. Est-ce que Zonemaster supporte IPv6 ? 

Oui, bien sûr. Tous les tests exécutés en IPv4, le seront aussi en IPv6, dans
la mesure ou Zonemaster est configuré pour le faire.

#### 7. Est-ce que Zonemaster supporte DNSSEC ?  

Oui, si des informations relatives à DNSSEC sont détectées au cours de l'analyse
de la zone à tester, leur conformité sera automatiquement vérifiée.

#### 8. Qu'est ce qui fait que Zonemaster est différent des outils existants ?  

Avant toute chose, Zonemaster conserve un historique des derniers tests 
réalisés sur une zone. Concrètement, cela signifie que vous pouvez revenir
analyser et comparer l'état d'une zone même après avoir corrigé les problèmes
rencontrés sur celle-ci.

Zonemaster va aussi essayer de vous présenter les résultats de ces analyses,
d'une manière lisible et compréhensible (bien que le caractère technique
de ceux-ci peut les rendre difficiles à comprendre pour un néophyte).

Zonemaster peut réaliser des tests sur une zone qui n'est pas encore
déléguées (plus de détails dans la réponse à la question "C'est quoi un test
sur un nom de domaine non délégué ?" ).

Il existe aussi la possibilité, pour les utilisateurs expérimentés, de
passer en mode "avancé" afin d'obtenir un niveau de détails accru.

Pour finir, cette version "open source" de Zonemaster a été écrite de
manière modulaire afin de permettre son intégration en tout ou partie dans
des systèmes existants.

#### 9. Zonemaster et confidentialité  

Puisque Zonemaster est accessible à tous, n'importe qui, peut vérifier
votre nom de domaine et consulter les historiques afférents. Toutefois, il
n'est pas possible de savoir qui a réalisé ces tests puisque cette information
n'est pas conservée (contrairement à l'heure et au jour du test).

#### 10. Qu'est-ce qui fait que je ne peux pas tester mon nom de domaine ? 

Si nous occultons le cas où le nom de domaine n'a pas d'existence au moment 
où le test est réalisé, il peut y avoir 2 raisons qui peuvent conduire à ce
résultat:

 - Afin de protéger l'outil d'abus qui consisteraient à interroger très souvent,
   depuis la même adresse IP, la même zone, une temporisation de 5 minutes a été
   mise en oeuvre entre 2 analyse considérée comme identiques. Dans la pratique,
   cela signifie, que si vous essayez d'analyser une zone dont vous avez déjà
   demandé le traitement il y a moins de 5 minutes, vous obtiendrez en retour
   le résultat de l'analyse précédente, qui aura été préalablement enregistré.

 - Zonemaster a été créé pour analyser des noms de domaine (comme afnic.fr) et
   non des noms de serveurs/services (comme www.afnic.fr), des tests de validation
   de l'entrée fournie sur la page Web sont réalisés. Cela ne devrait pas affecter
   la très grande majorité des noms de domaine mais il existe quelques rares cas
   ou cela est possible car si lors de ces tests de validation Zonemaster considère
   que ce nom de domaine ne peut pas exister, il n'exécutera aucun test dessus.
   Jusque là, le seul cas de faux positif rencontré concerne le cas où TOUS les
   serveurs de noms du nom de domaine à tester "mentent" quand à l'exsitence de
   ce nom de domaine. Ce cas très rare indique de toute façon une zone 
   particulièrement cassée. Nous devons corriger ce cas, n'hésitez pas à nous
   contacter si vous pensez que ce problème empêche l'analyse de votre zone.
   Ce contrôle sera amélioré par la suite, nous vous le garantissons.

#### 11. Quels genres de requêtes Zonemaster génère t-il ?

C'est une question à laquelle il est difficile d'apporter une réponse précise
puisqu'elle dépend de la configuration de la zone testée mais aussi de la zone
parente, de la configuration des serveurs de noms, ... Pour obtenir une bonne
idée des requêtes envoyées et des résultats reçus il est possible d'utiliser 
l'outil en mode "ligne de commande". Par ce biais, vous pourrez obtenir de 
très nombreux détails sur la nature des traitements effectués. Mais à moins 
de manipuler des données liées au DNS quotidiennement, ce niveau de détail 
pourra être considéré trop technique et réservé à un public averti, les autres 
pourront se contenter de l'interface "classique".

#### 12. C'est quoi un test sur un nom de domaine non délégué ? 

On va appeler, test sur un nom de domaine non délégué, un test réalisé sur
une zone non complètement publiée dans le DNS. Cela est particulièrement
pratique lors de la création d'une nouvelle zone ou pour le changement de
délégation d'une zone existante. Disons, que vous souhaitez déplacer la zone
"exemple.fr" du serveur de noms "ns1.afnic.fr" vers le serveur de noms 
"ns2.afnic.fr". Dans ce scénario vous pouvez réaliser un test sur un nom de 
domaine non délégué en indiquant le nom de la zone mais aussi le futur serveur
de la zone, à savoir "ns2.afnic.fr" AVANT que ce changement soit réellement 
effectué. Un résultat d'analyse positif (toutes les catégories de résultat
aparaissent en vert) vous permet d'être à peu près certain que le nouveau 
serveur est correctement configuré. 

#### 13. Comment tester une zone "reverse" avec ZoneMaster ?

Zonemaster peut être utilisé pour valider un certain nombre d'éléments lors
de la configuration d'une zone. Parmi ces éléments, il y a les vérifications
des zones inverses. Pour réaliser cela pour des adresses en IPv4, il faut
déjà connaître l'adresse réseau utilisée par votre système. Celle-ci se
termine quasiment toujours par un 0. Pour créer le nom de la zone à tester,
il faut supprimer ce zéro, inverse l'ordre des champs de l'adresse IP puis
ajouter le suffixe .in-addr.arpa. ce qui vous donne finalement le nom de 
la zone inverse.
Pour IPv6, c'est très semblable, mais ce sont les octets dont il faudra
inversé l'ordre et le suffixe à utiliser est .ip6.arpa. (consultez l'exemple 
fournit pour une illustration plus claire).

 *Exemple 1* - Cas d'une adresse réseau IPv4: L'adresse réseau du système est
194.98.30.0. Le nom de la zone inverse correspondante est 30.98.194.in-addr.arpa.
qui peut ensuite être analysée à l'aide de Zonemaster.

 *Exemple 2* - Cas d'une adresse réseau IPv6: L'adresse réseau du système est
2001:660:3003::/24. Le nom de la zone inverse correspondante est 
3.0.0.3.0.6.6.0.1.0.0.2.ip6.arpa. qui peut ensuite être analysée à l'aide de Zonemaster.

