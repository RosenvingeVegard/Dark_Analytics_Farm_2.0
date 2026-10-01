---
name: powerbi-nortura-backgrounds
description: "Velg riktig bakgrunn fra Nortura sitt Power BI-bakgrunnsbibliotek (19 maler — 18 i Bakgrunner_PP.pptx pluss ett bruker-bidratt tillegg, slide 19) for en gitt rapportside, og plasser hvert visual (KPI-kort, diagram, liste, måler, kalender, sidebar-nav osv.) i riktig sone med riktig posisjon, størrelse og rekkefølge. Bruk denne skillen alltid når en Power BI-rapportside skal bygges eller legges ut med Nortura-bakgrunnsbiblioteket, når det skal velges mellom de 19 tilgjengelige layoutene, eller når visuals skal plasseres, endres i størrelse eller omprioriteres på en Nortura-bakgrunn. Bruk den også når noen spør om sonekoordinater, antall paneler, sidebar/KPI-stripe-oppsett, eller hvilken bakgrunn som passer til et gitt sett visuals. Soneplasseringen i alle layoutene følger naturlig lesretning for et menneskeøye (topp-til-bunn, venstre-til-høyre, sammendrag før detalj) — det viktigste visualet skal alltid i sonen med lavest prioritetstall, resten følger den dokumenterte rekkefølgen."
---

# Power BI – velge bakgrunn og plassere visuals (Nortura)

> **Avviklet 2026-10-01, ikke slettet.** Nye sider skal bygges med
> `nortura-design:nortura-report-design`-skillen, som kopierer en ferdig
> malside (med bakgrunn, tema og riktig plasserte plassholdere) i stedet
> for å regne ut prosentkoordinater. Denne skillen dekker samme
> bakgrunnsbibliotek med en annen (manuell koordinat-) metode og kan
> fortsatt brukes til å *forstå* biblioteket, men ikke som kilde for
> posisjonering av nye visuals — se `nortura-report-design/README.md` for
> hvorfor. Bruk `nortura-report-design/SKILL.md`'s layoutkatalog i stedet.

Denne skillen hjelper en Power BI-agent med to ting, i rekkefølge:

1. **Velge** riktig bakgrunn blant de 19 malene (18 i `Bakgrunner_PP.pptx` + slide 19, bruker-bidratt), gitt et sett med visuals som skal på siden.
2. **Plassere** hvert visual i riktig sone, med riktig posisjon/størrelse, i riktig prioritetsrekkefølge (eye-flow).

Den dekker *ikke* selve redigeringen av `Bakgrunner_PP.pptx` (det er `pptx`-skillen sin jobb — se «Forhold til andre skills» nederst), og den dekker ikke datamodellering, DAX eller hvilke tall som skal vises — bare **hvilken bakgrunn** og **hvor visualet skal stå**.

## Bibliotekets 19 bakgrunner (kort oversikt)

| Slide | Grid-type | Soner | Passer til |
|---|---|---|---|
| 1 | Header (2 tekstblokker + aksent) + 1 fullbredde-panel | 4 | Ett fritt innholdsområde |
| 2 | Header + sidebar + fullbredde-panel | 5 | Nav + ett fritt innholdsområde |
| 3, 5 | Full-bleed, ingen deling | 1 | Ett dominerende visual |
| 4 | Sidebar (full høyde) + body | 2 | Nav + ett samlet innholdsområde |
| 6 | 2x2 grid | 4 | 4 likeverdige visuals |
| 7 | 1+2 (venstre full høyde + høyre delt) | 3 | 1 dominerende + 2 støttevisuals |
| 8 | 2+1 (venstre delt + høyre full høyde) | 3 | 2 mindre + 1 dominerende |
| 9 | Topp/bunn (1+1) | 2 | 2 stablede visuals |
| 10 | Sidebar (hjørne-aksent) + topp/bunn | 3 | 3 visuals, delvis nav |
| 11 | Sidebar + 2 kolonner | 3 | Nav + 2 jevnstore kolonner |
| 12 | Ren bakgrunn, ingen paneler | 0 | Visuals med egen kortramme |
| 13 | Sidebar + header + body | 3 | Nav + tittel/KPI + ett innholdsområde |
| 14 | Header + KPI-stripe (4) + body | 5 | 4 nøkkeltall + ett innholdsområde |
| 15 | Asymmetrisk (kol. A full høyde + kol. B delt + kol. C full høyde) | 4 | Fremhevet element i hver ende |
| 16 | Wireframe 01 (HR/Employee) | 8 | HR-dashboard: sammendrag, 4 persondata-kort, liste/kalender |
| 17 | Wireframe 02 (Project Management) | 13 | Prosjektstyring: nav+CTA, 4 KPI, graf/liste-tunge rader |
| 18 | Wireframe 03 (Financial BI) | 10 | Finans-BI: nav, 4 KPI, 4 diagrammer i 2x2 |
| 19 | Sidebar + header + bred rad + 2 kolonner (bruker-bidratt) | 5 | Nav + tittel/KPI + én bred rad + 2 jevnstore kolonner |

**Full geometri (nøyaktige koordinater, sonenavn, type og prioritet for alle 18) står i `references/layout-library.md` (lesbar) og `references/layouts.json` (maskinlesbar, samme data).** Les en av disse før du svarer med konkrete tall — ikke gjett koordinater fra oversikten over.

## Steg 1 — Kartlegg visualene som skal på siden

For hvert visual, notér:
- **Type**: KPI/nøkkeltall-kort, diagram (linje/stolpe/gruppert/multi-linje), liste/tabell, måler/gauge, profil-/bildekort, kalender, kort tekst/CTA.
- **Viktighet**: hva skal brukeren se først? (Rangér 1 = viktigst.)
- **Navigasjonsbehov**: trenger siden en fast venstre-nav (sidebar)?
- **KPI-behov**: trenger siden en egen rad med 3–4 små nøkkeltall øverst?

## Steg 2 — Velg bakgrunn

Bruk denne beslutningsrekkefølgen (stopp ved første treff som passer godt):

1. **Sidebar-nav nødvendig?** Ja → smal til slide 2, 4, 10, 11, 13, 17, 18, 19. Nei → smal til de øvrige.
2. **Egen KPI-stripe (3–4 nøkkeltall) nødvendig?** Ja → slide 14, 16, 17, 18. Nei → resten.
3. **Match sonetall og -type:** Tell hvor mange visuals som skal plasseres og match mot `zone_count` og sonetypene i referansefilen. Foretrekk eksakt treff på antall + type (f.eks. 4 like diagrammer i 2x2 → slide 6 eller 18 sin diagram-del; ett dominerende + noen støttevisuals → slide 7, 8 eller 15).
4. **Ingen god match?** Bruk den nærmeste (samme antall soner, avvikende type er ofte ok — et KPI-kort kan ligge i en «generic»-sone). Slå sammen visuals eller drop de minst viktige heller enn å tvinge et dårlig oppsett. Hvis biblioteket mangler en relevant kombinasjon helt, si fra at det bør legges til en ny bakgrunn (samme prosess som ble brukt for slide 13–18: definer grid + sonefunksjon, bygg i `Bakgrunner_PP.pptx` med `pptx`-skillen, oppdater `Segmenteringsmatrise_bakgrunner.xlsx` og denne skillens referansefiler).
5. **`slide 12` (ren bakgrunn)** brukes kun når visualene selv har egen kortramme/skygge (f.eks. innebygde Power BI-visuals med egen bakgrunn) og et ekstra hvitt panel ville dobbelt-ramme dem.

## Steg 3 — Plasser visuals i riktig rekkefølge (eye-flow)

Hver sone i referansefilen har et `priority`-tall. **Plasser det viktigste visualet i sonen med lavest tall**, og fortsett nedover i stigende rekkefølge. `nav`-soner er navigasjon, ikke innhold, og har ingen prioritet.

**Hvorfor rekkefølgen er som den er:**
- For **slide 16, 17 og 18** er rekkefølgen hentet direkte fra de nummererte eye-flow-pilene i de tre wireframe-bildene (Wireframe 01/02/03) — dette er hvordan et menneske faktisk leser akkurat de layoutene, og skal følges nøyaktig. Legg merke til at ikke alle soner er eksplisitt nummerert i wireframene (f.eks. «Reminder card» og «Time tracker» i Wireframe 02, «Line chart» i Wireframe 03) — disse er lagt bakerst i rekkefølgen som lavere-prioritert støtteinformasjon, siden wireframen selv ikke trekker en pil dit.
- For **slide 1–15** finnes det ingen tegnet eye-flow, så rekkefølgen er utledet etter samme leseprinsipp som wireframene demonstrerer: header/tittel og KPI-rad først, deretter topp-til-bunn og venstre-til-høyre, med eventuelle «fremhevede» soner (f.eks. en full-høyde venstrekolonne som ligner et profilkort) vektet tidlig.
- **Bruk aldri en tilfeldig eller alfabetisk rekkefølge** når flere visuals konkurrerer om de øverste sonene — viktighet skal alltid styre hvilket visual som havner i sonen med lavest prioritetstall, ikke hvilken rekkefølge visualene ble nevnt i.

**Kjent hull — mange filtre i én sidebar-sone:** en `nav`-sone er alltid oppgitt som ÉN udelt sone (typisk ~20% bredde × ~88% høyde) i alle 19 malene — ingen av dem definerer egne underplasser per filter. En rapportside med mange slicere (f.eks. 8+ globale filtre) må derfor selv stables vertikalt inni den ene sonen — det finnes ingen ferdig mal å lese av. Gjør dette ved å gruppere filtrene logisk (f.eks. tid → organisasjon/lokasjon → type) og fordele dem jevnt innenfor sonens høyde, med litt ekstra luft mellom gruppene. Bekreftet i praksis (Kvalitetsrapportering-rapporten, slide 13, 8 slicere): dette går fint uten skrolling så lenge hver slicer får minst ~85-90px høyde på et lerret i denne størrelsesordenen (1818×1028) — færre, høyere slicer-bokser er mer lesbare enn å presse inn flere enn nødvendig.

## Steg 4 — Regn om til Power BI-koordinater

Sonene er oppgitt i **prosent av lerretet** (`x_pct`, `y_pct`, `w_pct`, `h_pct`), fordi den faktiske pikselstørrelsen avhenger av hvilken oppløsning bakgrunnen eksporteres i, og hvilken sidestørrelse som er satt i Power BI.

1. **Sett Power BI-sidens størrelse** (Format side → Egendefinert) til samme sideforhold som lerretet: **1.7685:1** (bredde/høyde, tilsvarer 18.94" x 10.71"). Bruk gjerne PNG-eksportens faktiske pikselmål direkte som sidestørrelse — da stemmer 1:1.
2. **Regn om hver sone:**
   - `x_px = x_pct / 100 * sidebredde_px`
   - `y_px = y_pct / 100 * sidehøyde_px`
   - `w_px = w_pct / 100 * sidebredde_px`
   - `h_px = h_pct / 100 * sidehøyde_px`
3. Sett disse verdiene som **X-posisjon, Y-posisjon, Bredde, Høyde** på visualet i Power BI (Format → Egenskaper → Posisjon og størrelse).

Lerretets EMU-mål (kildesannhet, fra selve pptx-filen) og tilhørende tomme-mål ligger i `references/layouts.json` under `canvas_emu` / `canvas_inches` / `aspect_ratio`, i tilfelle noen trenger å regne fra PowerPoint-filen direkte i stedet for prosent.

## Steg 5 — Svar-format

Når du blir bedt om å legge ut en side, svar med en tabell i denne formen (ikke bare prosa):

| Visual | Sone (bakgrunn X) | X (px) | Y (px) | Bredde (px) | Høyde (px) | Prioritet |
|---|---|---|---|---|---|---|
| ... | ... | ... | ... | ... | ... | ... |

Nevn hvilken bakgrunn (slide-nummer) som ble valgt og hvorfor, kort, før tabellen.

## Referansefiler

- `references/layout-library.md` — alle 19 bakgrunner med sonenavn, type, prioritet og x/y/bredde/høyde i prosent. Les denne først for konkrete tall.
- `references/layouts.json` — samme data, maskinlesbart format (`layouts.<slideN>.zones[]`), pluss lerretets EMU/tomme-mål og sideforhold. Bruk denne hvis du skal skrive kode/skript som regner ut plasseringer automatisk.

## Forhold til andre skills

- **`pptx`-skillen** eier selve `Bakgrunner_PP.pptx`-filen — bruk den (ikke denne skillen) til å legge til, redigere eller eksportere bakgrunner. Denne skillen forutsetter at biblioteket allerede finnes og fokuserer bare på valg + plassering.
- **`xlsx`-skillen** brukes til å vedlikeholde `Segmenteringsmatrise_bakgrunner.xlsx` (den overordnede oversikten over biblioteket). Denne skillens referansefiler er en mer detaljert, koordinat-nøyaktig utgave av samme informasjon, ment for faktisk plassering — ikke en erstatning for matrisen, men et supplement til den.
- **`data:build-dashboard`, `data:create-viz`, `data:data-visualization`** gjelder HTML-dashboards og Python-diagrammer, ikke Power BI-rapportsider — ingen overlapp.
- **`frontend-design`** gir generelle designprinsipper for UI, men kjenner ikke dette spesifikke biblioteket eller dets nøyaktige sonekoordinater — utfyller denne skillen, erstatter den ikke.
- Ingen eksisterende skill i dette miljøet dekker Power BI-rapportlayout spesifikt — denne skillen fyller et reelt hull, ikke en duplisering.
