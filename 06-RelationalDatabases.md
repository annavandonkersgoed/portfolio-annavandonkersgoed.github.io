# Reletional databases

Relational databases worden vaak gebruikt bij het combineren van verschillende datasets. Dit is erg handig voor experiment waar verschillende datasets worden gebruikt maar er wel overlappende waarden aanwezig zijn. SQL is een programmeertaal wat vaak gebruikt word voor het verwerken van informatie in een relational database. In deze opdracht wordt er laten zien dat er met sql gewerkt kan worden. Er zijn verschillende screenshots gemaakt van code van het programma [DBeaver](https://dbeaver.io/). In dit programma is er gewerkt met PostgreSQL.

In dit voorbeeld wordt er een database gecreëerd voor een hypothetisch experiment waarbij er data is met informatie over planten en data over de kenmerken van de planten.

<div class="figure">
<img src="images/Sql_1.png" alt="Maken van een database en 2 tabellen" width="500px" />
<p class="caption">(\#fig:unnamed-chunk-1)Maken van een database en 2 tabellen</p>
</div>

Eerst wordt er een database gemaakt met de 2 tabellen erin waarin plant_id de verbindende key is tussen de 2 tabellen.

Daarna wordt de data toegevoed aan de tabellen (dit is random gegeneerde data dus niet reëel)
<div class="figure">
<img src="images/Sql_2.png" alt="Data toevoegen aan tabellen" width="900px" />
<p class="caption">(\#fig:unnamed-chunk-2)Data toevoegen aan tabellen</p>
</div>

Nadat de tabellen met data zijn gemaakt kan er met de data gewerkt worden. Kolommen kunnen bijvoorbeeld gefilterd worden en bepaalde kolommen kunnen geselecteerd worden. In de onderstaande afbeeldingen is dat laten zien.  

Selecteren van de data waarbij de kolom bloemkleur wordt gefilterd uit de tabel kenmerken: 
<div class="figure">
<img src="images/Sql_3.png" alt="Select command" width="600px" />
<p class="caption">(\#fig:unnamed-chunk-3)Select command</p>
</div>

Filteren van de data waarbij de kolom bladkleur wordt gefilterd op de bladeren die groen zijn uit de tabel kenmerken: 
<div class="figure">
<img src="images/Sql_4.png" alt="Where command" width="600px" />
<p class="caption">(\#fig:unnamed-chunk-4)Where command</p>
</div>

Ook kun je de 2 tabellen plant en kenmerken aan elkaar linken. Dit gebeurd door het inner_join command.
<div class="figure">
<img src="images/Sql_5.png" alt="Samenvoegen van 2 tabellen" width="1500px" />
<p class="caption">(\#fig:unnamed-chunk-5)Samenvoegen van 2 tabellen</p>
</div>

