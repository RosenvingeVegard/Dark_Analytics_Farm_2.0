# Layout-bibliotek — Bakgrunner_PP.pptx (19 bakgrunner)

Lerret: 17316450 x 9791700 EMU (18.9375" x 10.7083", sideforhold 1.7685:1).

Alle soner er oppgitt som prosent av lerretets bredde/høyde (x_pct, y_pct, w_pct, h_pct), målt fra øverste venstre hjørne. Bruk disse til å regne om til piksler på Power BI-siden (se `SKILL.md` for formel). `priority` er lesrekkefølgen (1 = viktigst/leses først). `nav` betyr at sonen er navigasjon, ikke et innholds-visual.

## Oversiktstabell

| Slide | Status | Grid-type | Soner | Bruksområde |
|---|---|---|---|---|
| 1 | Eksisterende | Header (2 tekstblokker + aksent) + 1 fullbredde-panel | 4 | Enkel side med tittel og ett fritt innholdsområde |
| 2 | Eksisterende | Header (2 tekstblokker + aksent) + sidebar + fullbredde-panel | 5 | Enkel side med tittel, nav-sidebar og ett fritt innholdsområde |
| 3 | Eksisterende | Full-bleed, ingen deling | 1 | Fokusside med ett dominerende visual (stort chart, matrise, kart) |
| 4 | Eksisterende | Sidebar (full høyde) + body | 2 | Side med navigasjon og ett samlet innholdsområde |
| 5 | Eksisterende | Full-bleed, ingen deling (variant) | 1 | Fokusside med ett dominerende visual (alternativ styling) |
| 6 | Eksisterende | 2x2 grid | 4 | 4 likeverdige visuals uten navigasjon |
| 7 | Eksisterende | 1+2 (venstre full høyde + høyre delt topp/bunn) | 3 | 1 dominerende visual + 2 mindre støttevisuals, uten navigasjon |
| 8 | Eksisterende | 2+1 (venstre delt topp/bunn + høyre full høyde) | 3 | 2 mindre visuals + 1 dominerende visual, uten navigasjon |
| 9 | Eksisterende | Topp/bunn (1+1) | 2 | 2 stablede visuals uten navigasjon |
| 10 | Eksisterende | Sidebar (hjørne-aksent, full høyde) + topp/bunn | 3 | 3 visuals med en hjørne-aksent, uten full sidebar-nav |
| 11 | Eksisterende | Sidebar (full høyde) + 2 kolonner | 3 | Navigasjon + 2 jevnstore innholdskolonner |
| 12 | Eksisterende | Ren bakgrunn, ingen paneler | 0 | Ren tekstur/bakgrunn - alle visuals styler selv sin egen kortramme |
| 13 | Ny | Sidebar + header + body | 3 | Navigasjon + egen tittel/KPI-sone + ett samlet innholdsområde |
| 14 | Ny | Header + KPI-stripe (4 kort) + body | 5 | Egen KPI-rad (4 nøkkeltall) over ett samlet innholdsområde, uten navigasjon |
| 15 | Ny | Asymmetrisk: kolonne A full høyde + kolonne B delt topp/bunn + kolonne C full høyde | 4 | Navigasjon-fri side med ett fremhevet element i hver ende og 2 mindre i midten |
| 16 | Ny | Wireframe 01 (HR/Employee): header + 4 kol. + 3-seksjon (midtre spenner 2 kol.) | 8 | HR/ansatt-dashboard: sammendrag øverst, 4 personrelaterte kort, liste/kalender nederst |
| 17 | Ny | Wireframe 02 (Project Management): sidebar (nav+promo) + header + KPI-stripe(4) + 2x(bred+smal+smal) | 13 | Prosjektstyring: navigasjon + CTA, 4 KPI-er, graf/liste-tunge rader under |
| 18 | Ny | Wireframe 03 (Financial BI): sidebar (kun nav) + header + KPI-stripe(4) + 2x(50/50) | 10 | Finans-BI: navigasjon, 4 KPI-er, 4 likeverdige diagrammer i 2x2 |
| 19 | Ny (bruker-bidratt 2026-09-29) | Sidebar + header + bred rad + 2 kolonner | 5 | Navigasjon + egen tittel/KPI-sone + én bred rad (dominerende chart/trend) + to jevnstore kolonner nederst |

## Slide 1 — Header (2 tekstblokker + aksent) + 1 fullbredde-panel
*Status: Eksisterende · Bruksområde: Enkel side med tittel og ett fritt innholdsområde · Antall soner: 4*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Sidetittel (bred tekstblokk) | 1 | title | 1.02 | 2.23 | 40.71 | 5.62 |  |
| 2 | Sidetittel (smal tekstblokk) | 2 | title | 58.27 | 2.23 | 26.79 | 5.62 |  |
| 3 | Aksent-indikator | 3 | accent | 86.24 | 2.23 | 12.82 | 5.62 | liten dekorativ pille, ikke egnet for visual |
| 4 | Innholdspanel (full bredde) | 4 | generic | 1.02 | 9.34 | 98.04 | 88.43 | ett stort åpent panel til fritt innhold |

## Slide 2 — Header (2 tekstblokker + aksent) + sidebar + fullbredde-panel
*Status: Eksisterende · Bruksområde: Enkel side med tittel, nav-sidebar og ett fritt innholdsområde · Antall soner: 5*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Sidetittel (bred tekstblokk) | 1 | title | 1.02 | 2.23 | 40.71 | 5.62 |  |
| 2 | Sidetittel (smal tekstblokk) | 1 | title | 58.27 | 2.23 | 26.79 | 5.62 | leses sammen med bred tekstblokk |
| 3 | Aksent-indikator | 2 | accent | 86.24 | 2.23 | 12.82 | 5.62 | liten dekorativ pille |
| 4 | Innholdspanel (bak sidebar) | 3 | generic | 22.22 | 9.34 | 76.84 | 88.43 | usynlig areal bak sidebar er trukket fra - viser reelt synlig areal |
| 5 | Sidebar (nav) | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | full høyde, ligger oppå innholdspanelet |

## Slide 3 — Full-bleed, ingen deling
*Status: Eksisterende · Bruksområde: Fokusside med ett dominerende visual (stort chart, matrise, kart) · Antall soner: 1*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Innholdspanel (full bredde) | 1 | generic | 1.02 | 9.34 | 98.04 | 88.43 | ett stort åpent panel |

## Slide 4 — Sidebar (full høyde) + body
*Status: Eksisterende · Bruksområde: Side med navigasjon og ett samlet innholdsområde · Antall soner: 2*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Innholdspanel | 1 | generic | 1.02 | 9.34 | 98.04 | 88.43 | hovedinnhold til høyre for sidebar |
| 2 | Sidebar (nav) | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | full høyde |

## Slide 5 — Full-bleed, ingen deling (variant)
*Status: Eksisterende · Bruksområde: Fokusside med ett dominerende visual (alternativ styling) · Antall soner: 1*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Innholdspanel (full bredde) | 1 | generic | 1.02 | 9.34 | 98.04 | 88.43 | variant av slide3, ett stort panel |

## Slide 6 — 2x2 grid
*Status: Eksisterende · Bruksområde: 4 likeverdige visuals uten navigasjon · Antall soner: 4*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Panel øverst venstre | 1 | generic | 1.02 | 9.34 | 48.12 | 43.45 |  |
| 2 | Panel øverst høyre | 2 | generic | 50.86 | 9.34 | 48.12 | 43.45 |  |
| 3 | Panel nederst venstre | 3 | generic | 1.02 | 54.6 | 48.12 | 42.22 |  |
| 4 | Panel nederst høyre | 4 | generic | 50.86 | 54.6 | 48.12 | 42.22 |  |

## Slide 7 — 1+2 (venstre full høyde + høyre delt topp/bunn)
*Status: Eksisterende · Bruksområde: 1 dominerende visual + 2 mindre støttevisuals, uten navigasjon · Antall soner: 3*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Venstre panel (full høyde) | 1 | profile | 1.02 | 9.34 | 48.12 | 87.48 | bred, høy sone - egnet for profilkort, bilde, stor liste |
| 2 | Høyre panel øverst | 2 | generic | 50.86 | 9.34 | 48.12 | 43.45 |  |
| 3 | Høyre panel nederst | 3 | generic | 50.86 | 54.6 | 48.12 | 42.22 |  |

## Slide 8 — 2+1 (venstre delt topp/bunn + høyre full høyde)
*Status: Eksisterende · Bruksområde: 2 mindre visuals + 1 dominerende visual, uten navigasjon · Antall soner: 3*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Venstre panel øverst | 1 | generic | 1.02 | 9.34 | 48.12 | 43.45 |  |
| 2 | Høyre panel (full høyde) | 2 | generic | 50.86 | 9.34 | 48.12 | 87.48 | egnet for liste/graf som trenger ekstra høyde |
| 3 | Venstre panel nederst | 3 | generic | 1.02 | 54.6 | 48.12 | 42.22 |  |

## Slide 9 — Topp/bunn (1+1)
*Status: Eksisterende · Bruksområde: 2 stablede visuals uten navigasjon · Antall soner: 2*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Panel øverst (full bredde) | 1 | generic | 1.02 | 9.34 | 97.7 | 43.45 |  |
| 2 | Panel nederst (full bredde) | 2 | generic | 1.02 | 54.6 | 97.7 | 42.22 |  |

## Slide 10 — Sidebar (hjørne-aksent, full høyde) + topp/bunn
*Status: Eksisterende · Bruksområde: 3 visuals med en hjørne-aksent, uten full sidebar-nav · Antall soner: 3*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Panel øvre (høyre for sidebar) | 1 | generic | 22.22 | 9.34 | 76.84 | 43.45 | usynlig areal bak sidebar er trukket fra |
| 2 | Panel nedre (høyre for sidebar) | 2 | generic | 22.22 | 54.32 | 76.84 | 43.45 | usynlig areal bak sidebar er trukket fra |
| 3 | Sidebar (nav, hjørne-aksent) | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | full høyde, dekker venstre 20% av begge rader |

## Slide 11 — Sidebar (full høyde) + 2 kolonner
*Status: Eksisterende · Bruksområde: Navigasjon + 2 jevnstore innholdskolonner · Antall soner: 3*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Midtre kolonne (bak sidebar) | 1 | generic | 22.22 | 9.34 | 27.03 | 88.43 | usynlig areal bak sidebar er trukket fra |
| 2 | Høyre kolonne | 2 | generic | 50.75 | 9.34 | 48.31 | 88.43 |  |
| 3 | Sidebar (nav) | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | full høyde |

## Slide 12 — Ren bakgrunn, ingen paneler
*Status: Eksisterende · Bruksområde: Ren tekstur/bakgrunn - alle visuals styler selv sin egen kortramme · Antall soner: 0*

_Ingen paneler — ren bakgrunn/tekstur._

## Slide 13 — Sidebar + header + body
*Status: Ny · Bruksområde: Navigasjon + egen tittel/KPI-sone + ett samlet innholdsområde · Antall soner: 3*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Header panel | 1 | title | 22.22 | 9.34 | 76.84 | 13.28 | tittel/KPI-oppsummering |
| 2 | Body panel | 2 | generic | 22.22 | 24.42 | 76.84 | 73.36 | hovedinnhold |
| 3 | Sidebar (nav) | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | full høyde |

## Slide 19 — Sidebar + header + bred rad + 2 kolonner
*Status: Ny (bruker-bidratt 2026-09-29, målt direkte fra PNG-eksporten — ingen kildeslide i `Bakgrunner_PP.pptx` ennå) · Bruksområde: Navigasjon + egen tittel/KPI-sone + én bred rad + to jevnstore kolonner nederst · Antall soner: 5*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Header panel | 1 | title | 22.22 | 9.34 | 76.84 | 13.28 | tittel/KPI-oppsummering, identisk med slide 13 sin header-sone |
| 2 | Bred rad (full bredde) | 2 | generic | 22.22 | 24.42 | 76.84 | 23.73 | egnet for ett dominerende chart/trendlinje |
| 3 | Nedre venstre kolonne | 3 | generic | 22.22 | 50.0 | 37.74 | 47.76 |  |
| 4 | Nedre høyre kolonne | 4 | generic | 61.33 | 50.0 | 37.73 | 47.76 |  |
| 5 | Sidebar (nav) | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | full høyde |

**Kilde-notat**: målt direkte fra `layouts/Bakgrunner_PP/Slide19.png`'s pikselinnhold (Python/Pillow, kant-deteksjon på hvite paneler mot bakgrunnen), ikke hentet fra `Bakgrunner_PP.pptx` — filen har ingen slide 19 ennå. Hvis kildeslidet siden legges til i PowerPoint-filen, reverifiser disse tallene mot den i stedet for det målte estimatet.

## Slide 14 — Header + KPI-stripe (4 kort) + body
*Status: Ny · Bruksområde: Egen KPI-rad (4 nøkkeltall) over ett samlet innholdsområde, uten navigasjon · Antall soner: 5*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | KPI card 1 | 1 | kpi | 1.02 | 9.34 | 23.75 | 10.21 |  |
| 2 | KPI card 2 | 2 | kpi | 25.78 | 9.34 | 23.75 | 10.21 |  |
| 3 | KPI card 3 | 3 | kpi | 50.55 | 9.34 | 23.75 | 10.21 |  |
| 4 | KPI card 4 | 4 | kpi | 75.31 | 9.34 | 23.75 | 10.21 |  |
| 5 | Body panel | 5 | generic | 1.02 | 21.35 | 98.04 | 76.42 | hovedinnhold under KPI-stripen |

## Slide 15 — Asymmetrisk: kolonne A full høyde + kolonne B delt topp/bunn + kolonne C full høyde
*Status: Ny · Bruksområde: Navigasjon-fri side med ett fremhevet element i hver ende og 2 mindre i midten · Antall soner: 4*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Left panel (full height) | 1 | profile | 1.02 | 9.34 | 28.87 | 88.43 | egnet for profilkort/detaljpanel |
| 2 | Middle panel top | 2 | generic | 30.91 | 9.34 | 38.26 | 43.32 |  |
| 3 | Middle panel bottom | 3 | generic | 30.91 | 54.46 | 38.26 | 43.32 |  |
| 4 | Right panel (full height) | 4 | list | 70.18 | 9.34 | 28.87 | 88.43 | egnet for liste som trenger ekstra høyde |

## Slide 16 — Wireframe 01 (HR/Employee): header + 4 kol. + 3-seksjon (midtre spenner 2 kol.)
*Status: Ny · Bruksområde: HR/ansatt-dashboard: sammendrag øverst, 4 personrelaterte kort, liste/kalender nederst · Antall soner: 8*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Header (title + KPI summary) | 1 | title | 1.02 | 9.34 | 98.04 | 13.28 | Wireframe 01 - HR/Employee |
| 2 | Task list | 2 | list | 75.31 | 61.99 | 23.75 | 35.78 | eksplisitt i wireframens eye-flow (node 5) - leses rett etter header |
| 3 | Calendar and schedule | 3 | calendar | 25.78 | 61.99 | 48.51 | 35.78 | eksplisitt i wireframens eye-flow (node 6) |
| 4 | Profile card | 4 | profile | 1.02 | 24.42 | 23.75 | 35.78 |  |
| 5 | Progress chart | 5 | chart | 25.78 | 24.42 | 23.75 | 35.78 |  |
| 6 | Time tracker | 6 | gauge | 50.55 | 24.42 | 23.75 | 35.78 |  |
| 7 | Onboarding status | 7 | generic | 75.31 | 24.42 | 23.75 | 35.78 |  |
| 8 | Detail / accordion | 8 | generic | 1.02 | 61.99 | 23.75 | 35.78 |  |

## Slide 17 — Wireframe 02 (Project Management): sidebar (nav+promo) + header + KPI-stripe(4) + 2x(bred+smal+smal)
*Status: Ny · Bruksområde: Prosjektstyring: navigasjon + CTA, 4 KPI-er, graf/liste-tunge rader under · Antall soner: 13*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Header | 1 | title | 22.22 | 9.34 | 76.84 | 13.28 |  |
| 2 | KPI card 1 | 2 | kpi | 22.22 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 3 | KPI card 2 | 3 | kpi | 41.68 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 4 | KPI card 3 | 4 | kpi | 61.15 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 5 | KPI card 4 | 5 | kpi | 80.61 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 6 | Project list | 6 | list | 80.61 | 36.43 | 18.45 | 29.77 | eksplisitt i wireframens eye-flow (node 5) - leses rett etter KPI-raden |
| 7 | Bar chart (wide) | 7 | chart | 22.22 | 36.43 | 37.91 | 29.77 | eksplisitt i wireframens eye-flow (node 6) |
| 8 | Team list (wide) | 8 | list | 22.22 | 68.0 | 37.91 | 29.77 | eksplisitt i wireframens eye-flow (node 7) |
| 9 | Progress gauge | 9 | gauge | 61.15 | 68.0 | 18.45 | 29.77 | eksplisitt i wireframens eye-flow (node 8) |
| 10 | Reminder card | 10 | generic | 61.15 | 36.43 | 18.45 | 29.77 | ikke nummerert i wireframen - lavere prioritet |
| 11 | Time tracker | 11 | gauge | 80.61 | 68.0 | 18.45 | 29.77 | ikke nummerert i wireframen - lavere prioritet |
| 12 | Sidebar promo / CTA | 12 | promo | 1.02 | 79.39 | 20.18 | 18.38 | lavest prioritet, sekundær CTA |
| 13 | Sidebar nav | nav | nav | 1.02 | 9.34 | 20.18 | 68.25 | Wireframe 02 - Project Management |

## Slide 18 — Wireframe 03 (Financial BI): sidebar (kun nav) + header + KPI-stripe(4) + 2x(50/50)
*Status: Ny · Bruksområde: Finans-BI: navigasjon, 4 KPI-er, 4 likeverdige diagrammer i 2x2 · Antall soner: 10*

| # | Sonenavn | Prioritet | Type | x% | y% | b% | h% | Merknad |
|---|---|---|---|---|---|---|---|---|
| 1 | Header | 1 | title | 22.22 | 9.34 | 76.84 | 13.28 |  |
| 2 | KPI card 1 | 2 | kpi | 22.22 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 3 | KPI card 2 | 3 | kpi | 41.68 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 4 | KPI card 3 | 4 | kpi | 61.15 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 5 | KPI card 4 | 5 | kpi | 80.61 | 24.42 | 18.45 | 10.21 | eksplisitt i wireframens eye-flow |
| 6 | Column chart | 6 | chart | 61.15 | 36.43 | 37.91 | 29.77 | eksplisitt i wireframens eye-flow (node 6) |
| 7 | Multi-line chart | 7 | chart | 61.15 | 68.0 | 37.91 | 29.77 | eksplisitt i wireframens eye-flow (node 7) |
| 8 | Grouped bar chart | 8 | chart | 22.22 | 68.0 | 37.91 | 29.77 | eksplisitt i wireframens eye-flow (node 8) |
| 9 | Line chart | 9 | chart | 22.22 | 36.43 | 37.91 | 29.77 | ikke nummerert i wireframen - lavere prioritet |
| 10 | Sidebar nav | nav | nav | 1.02 | 9.34 | 20.18 | 88.43 | Wireframe 03 - Financial BI |
