1
Hallo, mein Name ist Thorsten Butz und mein Thema heute ist die Windows-Ereignisanzeige
und das auf den zweiten Blick sehr interessante Cmdlet Get-WinEvent.
Schaut man in die Ereignisanzeige, stellt man schnell fest, dass das Problem
sicher nicht ist, dass man dort zu wenig Informationen findet.

2
Im Gegenteil, es ist die Suche nach der Stecknadel im Heuhaufen.
Was man wirklich braucht, sind leistungsfähige Werkzeuge zum Filtern der Informationen.
Schon in der Vergangenheit hatten wir Kommandozeilen-Werkzeuge zur Automation:
WMIC (WMI-Zugriff), wevtutil (seit Windows Vista) seien als Beispiele hier genannt.

3
Wenn man auf diese Befehle schaut, stellt man fest, dass man durchaus mächtige
Möglichkeiten des Filterns hat, um auf die XML-Daten dahinter zuzugreifen.
Aber man möchte sich natürlich möglichst nicht mit einer sehr komplexen
Syntax auseinandersetzen.

4 
Man kann die grafischen Oberfläche nutzen. Auch dort hat man neben
allgemeinen Übersichten Zugriff auf diese XML-Datenstruktur-
Aber wenn man sich mit Skriptsprachen beschäftigt, wünscht man sich ja eigentlich
ein Kommandozeilenwerkzeug, das eben so einfach zu bedienen ist wie die grafischen Oberfläche.

5 
Get-EventLog ist auf den ersten Blick der perfekte Kandidat.
Eingeführt mit der PowerShell in Version 1, ist die Befehlssyntax sehr
eingängig, sehr simpel.
Man kann auch Kollegen, die da vielleicht nicht so tief in der Automation stecken,
unmittelbar Code zeigen, der verständlich ist. 

6
Und mit Techniken wie dem Splatting kann man das Ganze noch ein bisschen vereinfachen.
Und da man ja nun mit der PowerShell arbeitet, kann man auf 
sehr einfache Art und Weise 24 Stunden zurückspringen,
was ich in diesem Beispiel getan habe.
So freundet sich schnell mit Get-EventLog an.

7 
Dann aber entdeckt man, dass Get-EventLog eine Reihe von Nachteilen hat.
Und der erste und offensichtlichste Nachteil ist, dass Get-EventLog lange nicht
alle Events anzeigt, die in irgendwelchen Protokollen verstreut liegen.

8
Die Übersicht umfasst vielleicht die wichtigen Protokolle, aber lange nicht alle.
Schaut man in die grafische Oberfläche oder bemüht man Get-WinEvent,
stellt man fest, es gibt hunderte von Protokollen und nur die wenigsten zeigt
Get-EventLog an, wohl aber Get-WinEvent.
Woran liegt das?

9
Im Kern liegt das an einer Neuerung in Windows Vista.
Seinerzeit hat man die Windows Event Log Engine komplett überarbeitet.
Und wenn man es ein bisschen vereinfacht, kann man sagen, Get-EventLog ist
noch ein Werkzeug für die alte Welt.
Get-WinEvent ist das Werkzeug für die neue Welt, mit dem man auf die neuen
Formate zugreifen kann und vollumfänglich Zugriff erlangt.

10
Das ist aber nur ein Nachteil von Get-EventLog. Get-EventLog ist nicht PowerShell 7 kompatibel.
Wenn man Get-EventLog aufruft in PowerShell 7
benutzt man eine Technik, die sich Implicit Remoting nennt.

11
Das wiederum kann man ausschalten. 
Nun versucht man die gleiche Aufgabe mit Get-WinEvent zu lösen,
die mit Get-EventLog gerade so einfach war.
Und dann stellt man fest, das es geht, aber es erscheint eigenartig,
dass ich dafür ein Where-Object brauche.

12
Denn die spezifischen Parameter, die ich dafür gerne hätte, die kennt Get-WinEvent nicht.
Wenn man ein bisschen sucht und die Dokumentation liest, findet man heraus, 
dass man den Parameter "FilterHashtable" nutzen kann.

13
Das Problem ist hiebei wiederum, dass man sich diese Syntax erarbeiten muss.
Sehr eigenartig. Es gibt einen besseren Weg.
Und der führt interessanterweise über die grafische Oberfläche.
Ich bin zurück in dem Event Viewer und dort kann man
unter den angepassten Ansichten

14
eigene Filterregeln bauen.
Das ist dann super, super simpel und man könnte es jetzt auf einem einzelnen
Rechner bei der grafischen Oberfläche sicher belassen.
Aber das eigentlich Interessante ist, man sieht es oben rechts
an dem gelben Pfeil, dass man dann auch die Möglichkeit hat,

15
die dahinterliegenden Filter sich im Detail ein bisschen genauer anzuschauen.
Und da sind wir wieder im Kontext von XML.
Nicht ganz einfach zu verstehen, schon gar nicht, wenn man das hier selber hinschreiben
müsste, aber naja, ich kann mit CTRL-C (Steuerung-C) den Text Kopieren.


16
Das wiederum macht es sehr simpel.
Es gibt bei Get-WinEvent einen zweiten
Parameter, der heißt FilterXML und der nimmt exakt das entgegen.
Da XML immer ein bisschen empfindlich ist,
sollte man da vorsichtig sein beim Ändern dieses Textes, 

17
so dass man das am besten in einen HereString einfasst.
Und auf dieser Folie sieht man das dann hier nochmal gegenübergestellt zu der
FilterHashtable, die wir gerade hatten und unten dem FilterXPath-Parameter,
den man alternativ benutzen kann. Vorsicht bei den Operatoren!

18
Kommen wir zu einer Demo zu den weiteren Vorteilen von Get-WinEvent.
Bisher sehen wir ja eigentlich nur, dass Get-WinEvent zwar mächtiger,
aber auch ein bisschen komplizierter zu sein scheint in der Anwendung.
Wir sehen das hier im Vergleich. Ich habe die verschiedenen Beispiele
in eine Demo-Datei gepackt. Die werde ich jetzt aufrufen.

19 
Dann schauen wir mal, was passiert, wenn wir einfach mal messen,
wie lange die Laufzeiten sind.
Und dann stellt man sehr schnell fest, da gibt es große Unterschiede.
Und da ein Test kein Test ist, wiederhole ich das direkt.
Es gibt bei Get-EventLog große Unterschiede, was durch dieses
Implicit Remoting zustande kommt. 

20
Beim zweiten Aufruf ist die Sitzung bereits aktiv, deswegen geht es dann schneller.
Die wirklich wichtige Information ist aber, das was wir gerade gesehen haben,
dass der XML-Ausdruck, den ich aus dem Event-Viewer rauskopieren kann,
nicht nur bequem ist, sondern auch noch die schnellste Option von allen darstellt.