Zonemaster
==========

1. [Zonemaster, c'est quoi ?](#q1)
2. [Qui se cache derrière Zonemaster ?](#q2)
3. [Qu'est-ce que Zonemaster peut faire pour moi?](#q3)
4. [Zonemaster indique des "Erreurs"/"Avertissements" sur ma zone, qu'est ce que cela signifie ?](#q4)
5. [Comment Zonemaster peut décider ce qui est correct de ce qui ne l'est pas?](#q5)
6. [Est-ce que Zonemaster supporte IPv6 ?](#q6)
7. [Est-ce que Zonemaster supporte DNSSEC ?](#q7)
8. [Qu'est ce qui fait que Zonemaster est différent des outils existants ?](#q8)
9. [Zonemaster et confidentialité](#q9)
10. [Comment se fait-il que je ne puisse pas tester mon nom de domaine ?](#q10)
11. [Quels genres de requêtes Zonemaster génère t-il ?](#q11)
12. [C'est quoi un test sur un domaine non délégué?](#undelegated)
13. [Comment tester une zone "reverse" avec Zonemaster ?](#q13)


#### 1. Zonemaster c'est quoi ? <a name="q1"></a>

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

#### 2. Qui se cache derrière Zonemaster ? <a name="q2"></a>

Zonemaster est un projet conjoint entre l'Afnic (multi-registre français de 
ccTLDs .fr, .re, .pm, .tf, .wf, .yt et de gTLDs .paris, ...) d'une part et
le .SE (registre suédois des ccTLDs .se et .nu) d'autre part.

#### 3. Qu'est-ce que Zonemaster peut faire pour moi ? <a name="q3"></a>

Zonemaster a été créé pour un public de techniciens, ou tout du moins pour
les personnes s'intéressant à la manière dont le DNS fonctionne. Il peut
par exemple être utilisé pour montrer aux responsables techniques de votre 
nom de domaine, qu'un problème de configuration est en cours en leur
fournissant le lien généré par Zonemaster qui se trouve à la fin de chaque 
analyse. Ainsi, si vous avez demandé une analyse et que vous souhaitez
montrer à quelqu'un le résultat de celle-ci vous pouvez juste copier le lien
fourni sur la page des résultats de tests. Le lien suivant, par exemple, 
renvoie sur les résultats de la dernière analyse de "afnic.fr": [https://zonemaster.net/test/18281](https://zonemaster.net/test/18281).

#### 4. Zonemaster indique des "Erreurs"/"Avertissements" sur ma zone, qu'est ce que cela signifie ? <a name="q4"></a>

Bien évidemment, cela dépend du type des tests qui ont échoué lors de l'analyse
de la zone. Dans la plupart des cas, vous pouvez cliquer sur le message d'erreur
ou d'avertissement pour obtenir plus de détails sur le problème qui a été détecté.

#### 5. Comment Zonemaster peut décider ce qui est correct de ce qui ne l'est pas ?  <a name="q5"></a>

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

#### 6. Est-ce que Zonemaster supporte IPv6 ? <a name="q6"></a>

Oui, bien sûr. Tous les tests exécutés en IPv4, le seront aussi en IPv6, dans
la mesure ou Zonemaster est configuré pour le faire.

#### 7. Est-ce que Zonemaster supporte DNSSEC ? <a name="q7"></a>

Oui, si des informations relatives à DNSSEC sont détectées au cours de l'analyse
de la zone à tester, leur conformité sera automatiquement vérifiée.

#### 8. Qu'est ce qui fait que Zonemaster est différent des outils existants ? <a name="q8"></a>

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

#### 9. Zonemaster et confidentialité <a name="q9"></a>

Puisque Zonemaster est accessible à tous, n'importe qui, peut vérifier
votre nom de domaine et consulter les historiques afférents. Toutefois, il
n'est pas possible de savoir qui a réalisé ces tests puisque cette information
n'est pas conservée (contrairement à l'heure et au jour du test).

#### 10. Qu'est-ce qui fait que je ne peux pas tester mon nom de domaine ?  <a name="q10"></a>

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

#### 11. Quels genres de requêtes Zonemaster génère t-il ? <a name="q11"></a>

C'est une question à laquelle il est difficile d'apporter une réponse précise
puisqu'elle dépend de la configuration de la zone testée mais aussi de la zone
parente, de la configuration des serveurs de noms, ... Pour obtenir une bonne
idée des requêtes envoyées et des résultats reçus il est possible d'utiliser 
l'outil en mode "ligne de commande". Par ce biais, vous pourrez obtenir de 
très nombreux détails sur la nature des traitements effectués. Mais à moins 
de manipuler des données liées au DNS quotidiennement, ce niveau de détail 
pourra être considéré trop technique et réservé à un public averti, les autres 
pourront se contenter de l'interface "classique".

#### 12. C'est quoi un test sur un nom de domaine non délégué ? <a name="undelegated"></a>

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

#### 13. Comment tester une zone "reverse" avec ZoneMaster ? <a name="q13"></a>

Zonemaster peut être utilisé pour valider un certain nombre d'éléments lors
de la configuration d'une zone. Parmi ces éléments, il y a les vérifications
des zones inverses. Pour réaliser cela pour des adresses en IPv4 ou IPv6, il faut
déjà connaître l'adresse réseau utilisée par votre système ainsi que le masque
de sous réseau de celui-ci. Ensuite il suffit de suivre la procédure décrite
ci-après pour les adresses IPv4 d'une part, et IPv6 d'autre part.

Pour les adresses de type IPv4:
  - Le cas sera différent selon que la taille du masque est un multiple de
    8 ou non, à titre d'illustration, nous ne parlons que du cas /24 (mais
    le raisonnement peut tout aussi bien s'appliquer avec un masque de type
    /8 ou /16).
  - Si le masque de sous réseau est /24 et que l'adresse réseau est, disons,
    "1.2.3.0", supprimer le dernier champ (ici "0"), inverser l'ordre des
    champs restants et y adjoindre le suffixe "in-addr.arpa". Dans ce cas,
    la zone inverse est "3.2.1.in-addr.arpa.". Celle-ci peut ensuite être
    soumise à Zonemaster pour vérification.
  - Dans le cas d'un sous réseau plus petit ayant un masque /28 par exemple,
    avec une adresse réseau "1.2.3.4", la zone inverse est obtenue en
    inversant l'ordre de l'ensemble des champs de l'adresse IP puis en
    ajoutant le suffixe "in-addr.arpa". Dans ce cas, "4.3.2.1.in-addr.arpa.".
    Celle-ci peut ensuite être soumise à Zonemaster pour vérification.

Pour les adresses de type IPv6:
  - Il faut dans un premier temps les écrire en mode "non abrégé". Inverser
    l'ordre de chaque lettre/chiffre que l'on séparera par un point, puis 
    ajouter le suffixe "ip6.arpa.".
  - C'est un peu compliqué, c'est pourquoi il existe une astuce simple pour
    trouver la zone "reverse" à l'aide de la commande "dig".
  - Faire la commande "dig -x 2001:660:3003:2::4:1" (l'adresse sera remplacée
    par l'adresse que l'on souhaite vérifier).
  - Dans la partie "authority section" de la réponse on trouve la zone inverse,
    soit "6.0.1.0.0.2.ip6.arpa." dans le cas présent. Celle-ci peut ensuite
    être soumise à Zonemaster pour vérification.
