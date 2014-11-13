Zonemaster
==========

1.	Zonemaster, c'est quoi ?
2. 	Qui se cache derrière Zonemaster ?
3. 	Pourquoi créer un nouvel outil plutôt que de maintenir les outils existants ?
4.	Le DNS, c'est quoi ?
5.	Zonemaster, comment ça marche ?
6.	Qu'est-ce que Zonemaster peut faire pour moi ?
7.	Zonemaster indique des "Erreurs"/"Avertissements" sur ma zone, qu'est ce que cela signifie ?
8.	Comment Zonemaster peut décider ce qui est correct de ce qui ne l'est pas ?
9.	Est-ce que Zonemaster supporte IPv6 ?
10.	Est-ce que Zonemaster supporte DNSSEC ? 
11.	Qu'est ce qui fait que Zonemaster est différent des outils existants ?
12.	Est-ce que Zonemaster peut analyser des zones qui ne sont ni en .fr, ni en .se ?
13.	Zonemaster et confidentialité
14.	Comment se fait-il que je ne puisse pas tester mon nom de domaine ?
15.	Quels genres de requêtes Zonemaster génère t-il ?
16.	C'est quoi un test sur un domaine non délégué ?
17. 	Comment tester une zone "reverse" avec Zonemaster ?

Zonemaster
----------

**1. Zonemaster c'est quoi ?**  

Zonemaster est un outil qui a été créé dans le but d'aider au diagnostique,
de mesurer et aussi permettre à ses utilisateurs de mieux comprendre le
fonctionnement du DNS (Domain Name System). Lorsqu'un nom de domaine (et 
conséquemment la zone à laquelle il fait référence) est soumis à Zonemaster, 
ce dernier va réaliser une analyse complète et parcourir l'arborescence des
noms de domaine en partant de la racine (.) jusqu'aux serveurs de noms 
contenant les informations pour la zone correspondante. Ceci afin de détecter
toute anomalie indiquant une non conformité ou faille qui pourrait conduire
à une mauvaise qualité du service. Ce qui inclut, des tests de connectivité,
de validité des adresses IP, de contrôle de validité des signatures DNSSEC...

**2. Qui se cache derrière Zonemaster ?**

Zonemaster est un projet conjoint entre l'Afnic (multi-registre français de 
ccTLDs .fr, .re, .pm, .tf, .wf, .yt et de gTLDs .paris, ...) d'une part et
le .SE (registre suédois des ccTLDs .se et .nu) d'autre part.

**3. Pourquoi créer un nouvel outil plutôt que de maintenir les outils existants ?**

Aussi bien l'Afnic que le .SE ont mis au point, pour leurs besoins propres,
des outils similaire. Il s'agit de ZoneCheck (http://zonecheck.fr) pour l'AFNIC
et de DNSCheck (http://dnscheck.iis.se) pour le .SE qui sont utilisés depuis
plusieurs années. La décision de créer un nouvel outil provient de l'idée 
d'intégrer les fonctionnalités des 2 outils, d'en améliorer les performances
tout en mutualisant les ressources de développement.

La première étape du projet Zonemaster a consisté à analyser aux plus près 
ces 2 outils afin de déterminer si nous pouvions les améliorer pour répondre à 
nos besoins respectifs, actuels et futurs ou si la meilleure solution était de
créer un outil "from-scratch". Après de longues discussions, nous avons décidé
de choisir cette seconde voie puisqu'aucun outil ne pouvait être amélioré
pour répondre à nos différents besoins tout en conservant la modularité que nous
recherchions. Le nouvel outil que nous allions développer devait être meilleur,
être le fruit d'une démarche transparente et collaborative et s'appuyer sur
des standards actuels en matière de développement logiciel.

**4. Le DNS, c'est quoi ?**  

Le système de noms de domaine (communément appelé DNS) est ce que l'on pourrait
appeler l'annuaire téléphonique de l'Internet. Il va permettre l'association, par
exemple, de noms de sites webs compréhensibles et facilement mémorisables pour
un humain (www.iis.se par exemple) avec les adresses IP réellements utilisées par 
les ordinateurs pour se connecter à ces sites et qui peuvent être complexes à
retenir (2a00:801:f0:106::80 dans notre exemple). Le DNS est aussi vital pour
le bon acheminement des Emails vers leurs destinataires. En résumé, le DNS
est stratégique pour les entreprises afin de maintenir leur activité de manière
optimale.

**5. Zonemaster, comment ça marche ?**  

Si vous êtes intéressé par de plus amples informations sur les aspects techniques
de Zonemaster, nous vous conseillons d'aller consulter les [spécifications des tests](https://github.com/dotse/zonemaster/tree/master/docs/specifications/tests).
Si cette page est trop technique, vous pouvez lire la première réponse de
cette FAQ à la question "Zonemaster, c'est quoi ?"

**6. Qu'est-ce que Zonemaster peut faire pour moi ?**  

Zonemaster a été créé pour un public de techniciens, ou tout du moins pour
les personnes s'intéressant à la manière dont le DNS fonctionne. Il peut
par exemple être utilisé pour montrer aux responsables techniques de votre 
nom de domaine, qu'un problème de configuration est en cours en leur
fournissant le lien généré par Zonemaster qui se trouve à la fin de chaque 
analyse. Ainsi, si vous avez demandé une analyse et que vous souhaitez
montrer à quelqu'un le résultat de celle-ci vous pouvez juste copier le lien
en bas de la page des résultats de tests. Le lien suivant, par exemple, 
renvoie sur les résultats de la dernière analyse de "afnic.fr":

 http://zonemaster.net/test/200 [Lien à vérifier]

**7. Zonemaster indique des "Erreurs"/"Avertissements" sur ma zone, qu'est ce que cela signifie ?**  

Bien évidemment, cela dépend du type des tests qui ont échoué lors de l'analyse
de la zone. Dans la plupart des cas, vous pouvez cliquer sur le message d'erreur
ou d'avertissement pour obtenir plus de détails sur le problème qui a été détecté.

**8. Comment Zonemaster peut décider ce qui est correct de ce qui ne l'est pas ?**  

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

Mais, avec les technonologies évolutives, comme le DNS, ce qui est aujourd'hui
un simple avertissement, peut devenir demain une faille de sécurité grave. Si
vous considérez que nous avons fait une erreur de jugement pour qualifier une
erreur, n'hésitez pas à nous en faire part en envoyant un Email à l'adresse
zonemaster-devel@lists.iis.se avec le lien sur le test réalisé et un commentaire
indiquant ce que vous pensez être incorrect dans notre diagnostique. (Si vous
ne savez pas quel lien envoyer, consulter la réponse à la question "Qu'est-ce 
que Zonemaster peut faire pour moi ?" qui se trouve dans cette FAQ)

**9. Est-ce que Zonemaster supporte IPv6 ?**  

Oui, bien sûr. Tous les tests exécutés en IPv4, le seront aussi en IPv6, dans
la mesure ou Zonemaster est configuré pour le faire.

**10. Est-ce que Zonemaster supporte DNSSEC ?**  

Oui, si des informations relatives à DNSSEC sont détectées au cours de l'analyse
de la zone à tester, leur conformité sera automatiquement vérifiée.

**11. Qu'est ce qui fait que Zonemaster est différent des outils existants ?**  

Avant toute chose, Zonemaster conserve un historique des derniers tests 
réalisés sur une zone. Concrètement, cela signifie que vous pouvez revenir
analyser et comparer l'état d'une zone même après avoir corrigé les problèmes
rencontrés sur celle-ci.

Zonemaster va aussi essayer de vous présenter les résultats de ces analyses,
d'une manière lisible et compréhensible (bien que le caractère technique
de ceux-ci peut les rendre difficiles à comprendre pour un néophyte).

Il existe aussi la possibilité, pour les utilisateurs expérimentés, de
passer en mode "avancé" afin d'obtenir un niveau de détails accru.

Pour finir, cette version "open source" de Zonemaster a été écrite de
manière modulaire afin de permettre son intégration en tout ou partie dans
des systèmes existants.

**12. Est-ce que Zonemaster peut analyser des zones qui ne sont ni en .fr, ni en .se ?**

Oui. La nature des zones pouvant être testées est complètement indépendante
de celles dont les registres AFNIC et .SE assurent la gestion.

**13. Zonemaster et confidentialité**  

Puisque Zonemaster est accessible à tous, n'importe qui, peut vérifier
votre nom de domaine et consulter les historiques afférents. Toutefois, il
n'est pas possible de savoir qui a réalisé ces tests puisque cette information
n'est pas conservée (contrairement à l'heure et au jour du test).

**14. Qu'est-ce qui fait que je ne peux pas tester mon nom de domaine ?**  

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

**15. Quels genres de requêtes Zonemaster génère t-il ?**  

C'est une question à laquelle il est difficile d'apporter une réponse précise
puisqu'elle dépend de la configuration de la zone testée mais aussi de la zone
parente, de la configuration des serveurs de noms, ... Pour obtenir une bonne
idée des requêtes envoyées et des résultats reçus il est possible d'utiliser 
l'outil en mode "ligne de commande". Par ce biais, vous pourrez obtenir de 
très nombreux détails sur la nature des traitements effectués. Mais à moins 
de manipuler des données liées au DNS quotidiennement, ce niveau de détail 
pourra être considéré trop technique et réservé à un public averti, les autres 
pourront se contenter de l'interface "classique".

**16. C'est quoi un test sur un nom de domaine non délégué ?**  

On va appeler, test sur un nom de domaine non délégué, un test réalisé sur
une zone non complètement publiée dans le DNS. Cela est particulièrement
pratique lors de la création d'une nouvelle zone ou pour le changement de
délégation d'une zone existante. Disons, que vous souhaitez déplacer la zone
"exemple.fr" du serveur de noms "ns1.afnic.fr" vers le serveur de noms 
"ns2.afnic.fr". Dans ce scénario vous pouvez réaliser un test sur un nom de 
domaine non délégué en indiquant le nom de la zone mais aussi le futur serveur
de la zone, à savoir "ns2.afnic.fr" AVANT que ce changement soit réellement 
effectué. Un résultat d'analyse positif vous permet d'être à peu près certain
que le nouveau serveur est correctement configuré. 

**17. Comment tester une zone "reverse" avec ZoneMaster ?**

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

