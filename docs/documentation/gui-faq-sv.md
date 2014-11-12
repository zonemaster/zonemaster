Zonemaster
==========

1.	Vad är Zonemaster?
2. 	Vem har utvecklat Zonemaster?
3. 	Varför ett nytt verktyg istället för att vidareutveckla de som redan finns?
4.	Vad är DNS?
5.	Hur funkar Zonemaster?
6.	Hur kan Zonemaster hjälpa mig?
7.	Zonemaster visar "Fel"/"Varning" när jag testar min domän, vad betyder det?
8.	Hur kan Zonemaster bedömma vad som är rätt eller fel konfigurerat?
9.	Kan Zonemaster hantera IPv6?
10.	Kan Zonemaster hantera DNSSEC? 
11.	Vad skiljer Zonemaster från annan mjukvara som testar domäner?
12.	Kommer Zonemaster fungera för min icke-.se/.fr-domän?
13.	Zonemaster och integritet 
14.	Varför kan jag inte testa min domän?
15.	Vilken typ av DNS-frågor genererar Zonemaster?
16.	Vad är ett odelegerat domäntest?
17. 	Hur kan jag testa en domän som är en baklängesuppslagningsdomän?

Zonemaster
----------

**1. Vad är Zonemaster?**  

DNSCheck är ett program designat för att hjälpa människor att kontrollera, mäta och förhoppningsvis också bättre förstå hur DNS, domain name system, fungerar. När en domän (även kallad zon) skickas till DNSCheck så kommer programmet att undersöka domänens hälsotillstånd genom att gå igenom DNS från roten (.) till TLD:n (toppdomänen, till exempel .SE) och till slut de DNS-servrar som innehåller information om den specificerade domänen (till exempel iis.se). DNSCheck utför även en hel del andra test, så som att kontrollera DNSSEC-signaturer, att de olika värdarna går att komma åt och att IP-adresser är giltiga.

**2. Vem har utvecklat Zonemaster?**

Zonemaster är ett samarbetsprojekt mellan .SE (Registry för TLD:erna .SE och .NU) och AFNIC
(Registry för TLD:n .FR och de mindre TLD:er som tillhör Frankfrike).

**3. Varför ett nytt verktyg istället för att vidareutveckla de som redan finns?**

Liknande Zonemaster så har både .SE och AFNIC deras egna delegeringskontrollsverktyg -
ZoneCheck (http://zonecheck.fr) and DNSCheck (http://dnscheck.iis.se), som både har varit
i drift i många år. Anledningen till att skapa ett nytt verktyg istället för att fortsätta
med utvecklingen av de redan existerande verktygen är att vi ville ta alla bra delarna
av båda men ändå utklassa de gamla verktygen både i hastighet och resursnyttjande.

Den första delen av samarbetsprojektet var att noggrant gå igenom verktygen vi redan hade.
När vi gjorde detta frågade vi oss själva vad fördelarna respektiva nackdelarna skulle vara
att antingen förbättra eller designa om en av de redan existerande verktygen snarare än
att bygga ett helt nytt verktyg. Efter långa diskussioner sinsemellan kom vi fram till
att ingen av de existerande verktygen kunde förbättras till den grad vi ville uppnå och
ändå behålla sin moduläritet och återanvändningsbarhet så vi beslutade oss att skapa
något bättre än de båda och samtidigt göra detta med en mycket mer transparent design. 

**4. Vad är DNS?**  

Domain name system (förkortat DNS) skulle kunna kallas Internets ”telefonbok”. Det ser till att läsbara namn på webbsidor (som www.iis.se) kan översättas till de mer svårbegripliga IP-adresser som datorerna behöver för att kommunicera med varandra (i detta fall 212.247.7.229).

Förutom att låta dig surfa på Internet med din webbläsare med hjälp av namn på webbsidor istället för IP-adresser ser DNS även till att din e-post hittar rätt. Med andra ord, ett stabilt DNS är nödvändigt för att de flesta företag ska kunna fungera och arbeta effektivt.

**5. Hur funkar Zonemaster?**  

Om du vill ha den tekniska informationen om hur Zonemaster fungerar råder vi dig att kolla specifikationerna av dess tester som ligger publikt på Github. Du hittar dessa på förljande URL: "https://github.com/dotse/zonemaster/tree/master/docs/specifications/tests". Om du är ute efter ett mindre tekniskt svar bör du först läsa svaret till frågan ”Vad är Zonemaster” på denna sida.

**6. Hur kan Zonemaster hjälpa mig?**  

Den nuvarande versionen av Zonemaster är avsedd för tekniker eller åtminstone de som är intresserade av att lära sig mer om hur DNS fungerar. Om du enbart vill låta den som är ansvarig för din domän (tech-c eller teknisk personal hos din DNS-leverantör) veta att det finns problem med din domän kan du använda länken som finns längst ner på resultatsidan efter att ett test utförts. Om du har kört ett test kan du således länka till just det specifika testresultatet genom att kopiera länken som då finns längst ner på sidan. Till exempel, länken här nedanför pekar på ett tidigare utfört test av ”iis.se”:

 http://zonemaster.net/test/200 [Verifiera denna länk senare]

**7. Zonemaster visar "Fel"/"Varning" när jag testar min domän, vad betyder det?**  

Det beror på vilket test det gäller. I de flesta fall kan du klicka på fel- eller varningsmeddelandet för att få mer information om vad det var för problem.

Till exempel, om vi skulle testa domänen ”iis.se” och få ett felmeddelande som säger ”DNS-servern ns.nic.se (212.247.7.228) svarar inte på anrop över UDP”. Vad innebär detta? Efter att vi klickar på meddelandet får vi mer detaljerad information. I det här fallet: ”DNS-servern svarade inte på anrop över UDP. Detta beror troligtvis på att DNS-servern inte är korrekt uppsatt eller en felaktigt konfigurerad brandvägg.” Lyckligtvis var detta bara ett exempel eftersom det där felet i praktiken betyder att en DNS-server är otillgänglig, så det är inte direkt ett harmlöst fel.

**8. Hur kan Zonemaster bedömma vad som är rätt och fel?**  

Ingen kan ge ett definitivt, slutgiltigt utlåtande om en domäns hälsa. Detta är 
viktigt att poängtera. .SE, AFNIC och människorna bakom Zonemaster påstår inte 
att Zonemaster alltid har helt rätt. I vissa fall går åsikter isär, speciellt 
mellan olika länder, men ibland även lokalt. Vi har tillsammans inom samarbetsprojektet
gjort vårt allra bästa att ta fram en så bra som möjligt policy för hur dessa
olika fel bedöms innan de presenteras för dig som användare av verktyget.

Men eftersom DNS utvecklas hela tiden kan situationer som idag bara kräver en 
varning räknas som allvarliga fel imorgon. Om du tror du hittat något som du tycker
vi felbedömt, tveka då inte att kontakta oss på hostmaster@zonemaster.net med en 
länk till ditt test och en förklaring av varför du anser att resultatet inte är
korrekt. (Hur man länkar till ett test hittar du i ”Hur kan Zonemaster hjälpa mig?”
-delen av denna FAQ.)

**9. Kan Zonemaster hantera IPv6?**  

Ja. Alla tester som körs över IPv4 kommer även köras över IPv6 om Zonemaster är konfigurerad att göra det.

**10. Kan Zonemaster hantera DNSSEC?**  

Ja. Om en domän som testas av Zonemaster har DNSSEC konfigurerat så kommer det testas automatiskt.

**11. Vad skiljer Zonemaster från annan mjukvara som testar domäner?**  

Först och främst sparar Zonemaster all testhistoria. Det innebär att du kan gå tillbaka och titta på ett test du gjorde för en vecka sedan och jämföra det med ett test du nyss gjorde.

Zonemaster försöker också förklara fel och varningar på ett tydligt sätt, även om dessa meddelanden kan vara svåra att förstå för en icke-tekniker. 

Det finns en ”avancerad” flik tillgänglig för de tekniker som föredrar mer detaljerad testinformation.

Zonemaster är dessutom öppen källkod och är modulärt uppbyggd. Du kan med andra ord återanvända delar av koden i dina egna system om du vill.

**12. Kommer Zonemaster fungera för min icke-.se/.fr-domän?**  

Ja. Alla test som utförs på .SE/.FR-domäner kommer utföras på din zon också.

**13. Zonemaster och integritet**  

Eftersom Zonemaster är tillgänglig för alla är det också möjligt för vem som helst att kontrollera din domän och också se testhistoria för din domän. Det finns dock inget sätt att se vem som har gjort ett test eftersom det enda som loggas är tidpunken då testet gjordes.

**14. Varför kan jag inte testa min domän?**  

Om vi utgår från att domänen du försöker testa faktiskt existerar så finns det två saker som kan orsaka detta:

1. För att förhindra att flera test görs samtidigt på samma zon från samma IP-adress finns det en påtvingad fördröjning på 5 minuter mellan identiska test. Detta innebär att du inte kan testa en domän oftare än var 5:e minut. Om du testar din domän igen innan 5 minuter förflutit så visas det senast sparade resultatet.

2. Eftersom Zonemaster är designad för att testa domäner (som iis.se) och inte värdnamn i en domän (som www.iis.se) kontrollerar Zonemaster webbsida domänen du skrivit in innan den skickas vidare till Zonemasters testmotor för att se att det verkligen är en domän. Denna kontroll kan i vissa sällsynta fall misslyckas (och zonen således inte godkänns som korrekt). De enda gånger vi sett detta hända är ifall de DNS-servrar som tillhör den zon du försöker testa är väldigt trasiga. Hör gärna av dig ifall detta hänt dig så vi får mer information om hur vi kan korrigera hur detta test av domänen utförs. Det här testet kommer att förbättras, det lovar vi.

**15. Vilken typ av DNS-frågor genererar Zonemaster?**  

Det här är en svår fråga att svara på eftersom Zonemaster kommer att generera olika typer av anrop beroende på hur dina DNS-servrar svarar. Det enklaste sättet att se exakt vad Zonemaster testar är att köra ”zonemaster-cli” CLI-kommandot. Resultatet ger grundlig information om vad som händer under testet. Det bör dock nämnas att utmatningen från CLI-verktyget är väldigt tekniskt utmanande så ifall du inte gillar bits och bytes kanske du vill undvika det.

**16. Vad är ett odelegerat domäntest?**  

Ett odelegerat domäntest är ett test som genomförs på en domän som kan (men inte måste) vara fullständigt publicerad i DNS. Detta kan vara mycket användbart om du tänker flytta din domän från en registrar till en annan. Låt oss ta som exempel att din domän example.se ska flyttas från namnservern ’ns.nic.se’ till namnservern ’ns.iis.se’. I detta fall skulle du kunna köra ett odelegerat domäntest på domänen (example.se) med den namnservern du ska flytta till (ns.iis.se) INNAN du genomför själva flytten. När testet visar grönt så kan du vara tämligen säker på att den nya hemvisten för din domän åtminstone vet att den ska svara på frågor om din domän. Det kan emellertid fortfarande finnas fel i zoninformationen som detta test inte känner till.

**17. Hur kan jag testa en domän som är en baklängesuppslagningsdomän?**

Zonemaster kan användas för att testa diverse tekniska kriterier innan en zon publiceras i DNS.
Den kan även användas för att testa en baklängesuppslagningszon. För att göra detta med en IPv4-adress
måste du först ta reda på nätverksadressen för ditt system (denna slutar nästan alltid med en 0:a).
När du hittat denna tar du bort den sista 0:an, sedan byter du ordning på de nummer du fått fram och
lägger till suffixet: in-addr.arpa. Detta ger dig din "baklängesuppslagningszon".
För att göra samma sak med en IPv6-adress gör du på samma sätt som för en IPv4-adress; reversera ordningen
och lägg sedan till suffixet ip6.arpa.

*Exempel 1* - Baklängesuppslagning för ett IPv4-nät: har vi t.ex. nätadressen 194.98.30.0 så
ger oss detta baklängeszonen "30.98.194.in-addr.arpa". Denna zon kan sedan testas av Zonemaster.

*Exempel 2* - Baklängesuppslagning för ett IPv6-nät: har vi t.ex. nätadressen 2001:660:3003::0 så
ger oss detta baklängeszonen "3.0.0.3.0.6.6.0.1.0.0.2.ip6.arpa". Denna zon kan sedan testas av Zonemaster.
