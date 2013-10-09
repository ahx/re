# Re: E-Mail-Empfangsbestätigung für Jedermann

Dies ist die Server-Komponente von Re

## Projektidee

Behörden und große Unternehmen wie z.B. Google speichern und analysieren alle Anfragen an ihre Server, um mehr über ihre Kunden zu erfahren. Das Projekt Re will solche Methoden aufzeigen und transparent machen, indem es dem Kunden bzw. Bürger die gleichen Werkzeuge bereitstellt. Mit Re kann jedermann das Verhalten von Unternehmen und Behörden analysieren.

Das World Wide Web basiert auf einem einfachen Prinzip: Request-Response. Ein Web-Browser stellt eine Anfrage an einen Server im Internet, dieser liefert eine Antwort z.B. in Form einer HTML-Seite oder einer Bild-Datei. Mit der Anfrage an den Server werden auch Daten über den Anfragenden übermittelt. Diese Daten lassen sich speichern und auswerten.

Beim [BremenHack](http://bremen.stadthack.de) wurde ein Add-on für das E-Mail-Programm [Thunderbird](http://www.mozilla.org/de/thunderbird/) entwickel, mit dem man mit einem Klick ein Tracking-Bild in seine E-Mail einfügen kann, sowie ein Server zum Generieren und Ausliefern dieser Tracking-Bilder. Sobald eine durch das Add-on markierte E-Mail geöffnet, bzw. das Bild darin geladen wird, wird der Absender per E-Mail darüber benachrichtigt: "Deine E-Mail wurde geöffnet".

* Server: [https://github.com/ahx/re](https://github.com/ahx/re)
* Thunderbird-Plugin: [http://re.de.a9sapp.eu](https://github.com/ahx/re)

## Installation

This is a pretty basic Rails app that runs on Ruby 2 and Rails 4.

Installation steps:
* Install Ruby, then the bundler Rubygem
* Bundle dependencies `cd re && bundle`
* Start the app in develoment `rails server`
