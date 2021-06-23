# r-markdown-sql-project
R Markdown analytical project using SQL and ggplot2 for my Database Computer Science classes. [specific requirements in Polish]

## Opis zadania
Zadanie polega na przeprowadzeniu analizy danych dotyczących opóźnień połączeń lotniczych w USA w lipcu 2017 r.:
* dane wraz z opisem są udostępnione przez Departament Transportu Stanów Zjednoczonych,
* zaimportowane dane gotowe do analizy znajdują się na serwerze mssql-2017.labs.wmi.amu.edu.pl w bazie dbad_flights,
* spakowane pliki SQL znajdują się w pliku flights-create-insert.zip (ok. 140 MB po rozpakowaniu; plików nie należy importować do swojej bazy na serwerze wydziałowym; w przypadku pracy zdalnej zalecane jest łączenie się przez VPN do wydziałowego serwera MSSQL),

Raport powinien zawierać:
* imię i nazwisko autora dokumentu,
* datę wygenerowania raportu,
* odpowiedzi na poniższe pytania, wygenerowane na podstawie danych z bazy danych.

Raport powinien odpowiadać na poniższe pytania:
* Jakie było średnie opóźnienie przylotu?
* Jakie było maksymalne opóźnienie przylotu?
* Który lot miał największe opóźnienie przylotu?
[przewoźnik, miasto wylotu, miasto przylotu, data lotu, opóźnienie]
* Które dni tygodnia są najgorsze do podróżowania?
[tabela zawierająca dla każdego dnia tygodnia średni czas opóźnienia]
* Które linie lotnicze latające z San Francisco (SFO) mają najmniejsze opóźnienia przylotu?
[tabela zawierająca nazwę przewoźnika oraz średnie opóźnienie z jego wszystkich lotów]
* Jaka część linii lotniczych ma regularne opóźnienia, tj. jej lot ma średnio co najmniej 10 min. opóźnienia?
[tylko linie lotnicze występujące w tabeli `Flight_delays`]
* Jak opóźnienia wylotów wpływają na opóźnienia przylotów?
[współczynnik korelacji Pearsona między czasem opóźnienia wylotów a czasem opóźnienia przylotów]
* Która linia lotnicza miała największy wzrost (różnica) średniego opóźnienia przylotów w ostatnim tygodniu miesiąca, tj. między 1-23 a 24-31 lipca?
[nazwa przewoźnika oraz wzrost]
* Które linie lotnicze latają zarówno na trasie SFO → PDX (Portland), jak i SFO → EUG (Eugene)?
* Jak najszybciej dostać się z Chicago do Stanfordu, zakładając wylot po 14:00 czasu lokalnego?
[tabela zawierająca jako miejsce wylotu Midway (MDW) lub O'Hare (ORD), jako miejsce przylotu San Francisco (SFO), San Jose (SJC) lub Oakland (OAK) oraz średni czas opóźnienia przylotu dla wylotów po 14:00 czasu lokalnego (atrybut `crs_dep_time`); wyniki pogrupowane po miejscu wylotu i przylotu, posortowane malejąco]

Raport musi zostać przygotowany przy pomocy języka R oraz Markdowna. Do każdego z punktów należy przygotować odpowiednie polecenie SELECT, które następnie należy umieścić w kodzie R.

Wynikowy raport PDF ma zostać wygenerowany przy pomocy Markdowna. W raporcie PDF mają być widoczne sformatowane zapytania SQL oraz wygenerowane odpowiedzi.

Przy każdym pytaniu musi znajdować się kod R odpowiedzialny za odpowiedź na postawione pytanie.
