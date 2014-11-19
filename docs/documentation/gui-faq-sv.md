Zonemaster
==========

1.	Vad är Zonemaster?
2. 	Vem har utvecklat Zonemaster?
3.	Hur kan Zonemaster hjälpa mig?
4.	Zonemaster visar "Fel"/"Varning" när jag testar min domän, vad betyder det?
5.	Hur kan Zonemaster bedömma vad som är rätt eller fel konfigurerat?
6.	Kan Zonemaster hantera IPv6?
7.	Kan Zonemaster hantera DNSSEC? 
8.	Vad skiljer Zonemaster från annan mjukvara som testar domäner?
9.	Zonemaster och integritet 
10.	Varför kan jag inte testa min domän?
11.	Vilken typ av DNS-frågor genererar Zonemaster?
12.	Vad är ett odelegerat domäntest?
13. 	Hur kan jag testa en domän som är en baklängesuppslagningsdomän?

Zonemaster
----------

**1. Vad är Zonemaster?**  

Zonemaster är ett program designat för att hjälpa människor att kontrollera, mäta och förhoppningsvis också bättre förstå hur DNS, domain name system, fungerar. Zonemaster består av 3 huvuddelar: 1. Motorn (all kod som genomför alla tester), 2. Kommandoradsinterfacet (CLI) samt 3. webbgränssnittet. När en domän (även kallad zon) skickas till Zonemaster så kommer programmet att undersöka domänens hälsotillstånd genom att gå igenom DNS från roten (.) till TLD:n (toppdomänen, till exempel .NET) och till slut de DNS-servrar som innehåller information om den specificerade domänen (till exempel zonemaster.net). Zonemaster utför även en hel del andra tester och alla dessa är dokumenterade här: [Test Requirements document](https://github.com/dotse/zonemaster/blob/master/docs/requirements/TestRequirements.md)

**2. Vem har utvecklat Zonemaster?**

Zonemaster är ett samarbetsprojekt mellan .SE (Registry för TLD:erna .SE och .NU) och AFNIC
(Registry för TLD:n .FR och de mindre TLD:er som tillhör Frankfrike).

**3. Hur kan Zonemaster hjälpa mig?**  

Zonemaster är designat för 2 typer av människor: 1. Människor som vet hur DNS-protokollet fungerar och 2. Människor som enbart vill veta om deras domän är korrekt uppsatt och inte kommer få några problem i framtiden.

Ni som hör till kategori 2 bör kontakta de i kategori 1 för att felsöka er(a) domäner om ni får resultat ni inte förstår eller är nöjda med (allt grönt). Detta görs enklast genom att skicka med länken till ert test när ni kontakter er DNS-operatör/registrar.

**4. Zonemaster visar "Fel"/"Varning" när jag testar min domän, vad betyder det?**  

Det beror på vilket test det gäller. I de flesta fall kan du klicka på fel- eller varningsmeddelandet för att få mer information om vad det var för problem.

Till exempel, om vi skulle testa domänen ”iis.se” och få ett felmeddelande som säger ”DNS-servern ns.nic.se (212.247.7.228) svarar inte på anrop över UDP”. Vad innebär detta? Efter att vi klickar på meddelandet får vi mer detaljerad information. I det här fallet: ”DNS-servern svarade inte på anrop över UDP. Detta beror troligtvis på att DNS-servern inte är korrekt uppsatt eller en felaktigt konfigurerad brandvägg.” Lyckligtvis var detta bara ett exempel eftersom det där felet i praktiken betyder att en DNS-server är otillgänglig, så det är inte direkt ett harmlöst fel.

**5. Hur kan Zonemaster bedömma vad som är rätt och fel?**  

Ingen kan ge ett definitivt, slutgiltigt utlåtande om en domäns hälsa. Detta är 
viktigt att poängtera. .SE, AFNIC och människorna bakom Zonemaster påstår inte 
att Zonemaster alltid har helt rätt. I vissa fall går åsikter isär, speciellt 
mellan olika länder, men ibland även lokalt. Vi har tillsammans inom samarbetsprojektet
gjort vårt allra bästa att ta fram en så bra som möjligt policy för hur dessa
olika fel bedöms innan de presenteras för dig som användare av verktyget.

En fördel för dig som användare är dock att det är enkelt att skapa en egen policy för hur
allvarliga vissa fel ska vara, via CLI-verktyget går det att direkt peka ut sin egen policy.

Men eftersom DNS utvecklas hela tiden kan situationer som idag bara kräver en 
varning räknas som allvarliga fel imorgon. Om du tror du hittat något som du tycker
vi felbedömt, tveka då inte att kontakta oss på hostmaster@zonemaster.net med en 
länk till ditt test och en förklaring av varför du anser att resultatet inte är
korrekt. (Hur man länkar till ett test hittar du i ”Hur kan Zonemaster hjälpa mig?”
-delen av denna FAQ.)

**6. Kan Zonemaster hantera IPv6?**  

Ja. Alla tester som körs över IPv4 kommer även köras över IPv6 om Zonemaster är konfigurerad att göra det.

**7. Kan Zonemaster hantera DNSSEC?**  

Ja. Om en domän som testas av Zonemaster har DNSSEC konfigurerat så kommer det testas automatiskt.

**8. Vad skiljer Zonemaster från annan mjukvara som testar domäner?**  

Först och främst sparar Zonemaster all testhistoria. Det innebär att du kan gå tillbaka och titta på ett test du gjorde för en vecka sedan och jämföra det med ett test du nyss gjorde.

Zonemaster försöker också förklara fel och varningar på ett tydligt sätt, även om dessa meddelanden kan vara svåra att förstå för en icke-tekniker. 

Zonemaster kan också testa icke-publiserade/odelegerade domäner (mer om detta i FAQ-fråga nr 12).

Det finns en ”avancerad” flik tillgänglig för de tekniker som föredrar mer detaljerad testinformation.

Zonemaster är dessutom öppen källkod och är modulärt uppbyggd. Du kan med andra ord återanvända delar av koden i dina egna system om du vill.

**9. Zonemaster och integritet**  

Eftersom Zonemaster är tillgänglig för alla är det också möjligt för vem som helst att kontrollera din domän och också se testhistoria för din domän. Det finns dock inget sätt att se vem som har gjort ett test eftersom det enda som loggas är tidpunken då testet gjordes.

**10. Varför kan jag inte testa min domän?**  

Om vi utgår från att domänen du försöker testa faktiskt existerar så finns det två saker som kan orsaka detta:

1. För att förhindra att flera test görs samtidigt på samma zon från samma IP-adress finns det en påtvingad fördröjning på 5 minuter mellan identiska test. Detta innebär att du inte kan testa en domän oftare än var 5:e minut. Om du testar din domän igen innan 5 minuter förflutit så visas det senast sparade resultatet.

2. Eftersom Zonemaster är designad för att testa domäner (som zonemaster.net) och inte värdnamn i en domän (som www.zonemaster.net) kontrollerar Zonemaster webbsida domänen du skrivit in innan den skickas vidare till Zonemasters testmotor för att se att det verkligen är en domän. Denna kontroll kan i vissa sällsynta fall misslyckas (och zonen således inte godkänns som korrekt). De enda gånger vi sett detta hända är ifall de DNS-servrar som tillhör den zon du försöker testa är väldigt trasiga. Hör gärna av dig ifall detta hänt dig så vi får mer information om hur vi kan korrigera hur detta test av domänen utförs. Det här testet kommer att förbättras, det lovar vi.

**11. Vilken typ av DNS-frågor genererar Zonemaster?**  

Det här är en svår fråga att svara på eftersom Zonemaster kommer att generera olika typer av anrop beroende på hur dina DNS-servrar svarar. Det enklaste sättet att se exakt vad Zonemaster testar är att köra ”zonemaster-cli” CLI-kommandot. Resultatet ger grundlig information om vad som händer under testet. Det bör dock nämnas att utmatningen från CLI-verktyget är väldigt tekniskt utmanande så ifall du inte gillar bits och bytes kanske du vill undvika det.

**12. Vad är ett odelegerat domäntest?**  

Ett odelegerat domäntest är ett test som genomförs på en domän som kan (men inte måste) vara fullständigt publicerad i DNS. Detta kan vara mycket användbart om du tänker flytta din domän från en registrar till en annan. Låt oss ta som exempel att din domän example.se ska flyttas från namnservern ’ns.nic.se’ till namnservern ’ns.iis.se’. I detta fall skulle du kunna köra ett odelegerat domäntest på domänen (example.se) med den namnservern du ska flytta till (ns.iis.se) INNAN du genomför själva flytten. När testet visar grönt så kan du vara tämligen säker på att den nya hemvisten för din domän åtminstone vet att den ska svara på frågor om din domän. Det kan emellertid fortfarande finnas fel i zoninformationen som detta test inte känner till.

**13. Hur kan jag testa en domän som är en baklängesuppslagningsdomän?**

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
