## Dokumentation

Ich habe mit Terraform eine lokale Multi-Container-Anwendung auf Basis von Docker umgesetzt. Ziel war es, eine Infrastruktur zu definieren, bei der zwei Container (ein Nginx-Reverse-Proxy und eine einfache Python-App) gemeinsam in einem Docker-Netzwerk betrieben werden.

Das zugrunde liegende Problem war, dass man bei manueller Bereitstellung per Docker-CLI jedes Mal Netzwerke, Container, Portweiterleitungen und Verknüpfungen selbst konfigurieren müsste. Dies ist fehleranfällig, schwer wartbar und nicht wiederverwendbar. Mit Terraform kann die Infrastruktur einmal deklarativ definiert und jederzeit konsistent und reproduzierbar neu erzeugt werden.

Der gewählte Anwendungsfall eignet sich besonders gut zur Anwendung von Infrastructure as Code, da mehrere Ressourcen mit Abhängigkeiten und Konfigurationsdetails automatisiert verwaltet werden. Terraform bietet hier durch seine klare Struktur, Modulfähigkeit und Variablenunterstützung eine deutliche Vereinfachung im Vergleich zu manuellen Prozessen.

In meiner Lösung habe ich folgende zentrale Bausteine von Terraform genutzt:

- **Provider**: Ich verwende den `kreuzwerker/docker`-Provider zur Verwaltung lokaler Docker-Ressourcen.
- **Ressourcen**: Es werden zwei `docker_container`-Ressourcen (nginx und python) sowie ein gemeinsames `docker_network` definiert.
- **Variablen**: Es werden verschiedene Variablen eingesetzt:
  - `container_name` (string) für flexible Benennung
  - `image` (string) für das jeweilige Container-Image
  - `internal_port` und `external_port` (number) für die Portweiterleitung
  - (optional) `env_vars` (list oder map), um Umgebungsvariablen zu ermöglichen
- **Locals**: Ich habe einen `locals`-Block verwendet, um z. B. zusammengesetzte Container-Namen aus Variablen zu berechnen.
- **Outputs**: Zwei `output`-Blöcke geben die Container-IDs aus, um das Ergebnis zu überprüfen oder weiterzuverarbeiten.
- **Module**: Die Konfiguration verwendet ein generisches Modul namens `container_service`, das einen Container mit Parametern (Name, Image, Ports, Netzwerk) erstellt. Dadurch ist Wiederverwendung und eine strukturierte Organisation möglich.

Das Projekt ist nicht trivial, weil es mehrere zusammenhängende Ressourcen kombiniert, modulare Wiederverwendung ermöglicht, unterschiedliche Konfigurationsbausteine nutzt und Parameterisierung sowie lokale Berechnungen einsetzt. Die Infrastruktur kann jederzeit neu aufgebaut, geändert und wieder zerstört werden.

Im Vergleich zu einem manuellen Vorgehen per `docker run`-Befehlen bietet Terraform eine klar nachvollziehbare, versionskontrollierte und automatisierbare Lösung. Änderungen an Variablen oder der Infrastrukturstruktur lassen sich leicht vornehmen und mit `plan` und `apply` gezielt ausrollen.

Zu den Herausforderungen gehörten:
- Fehlerhafte Initialisierung des Docker-Providers aufgrund von Verwechslung zwischen `hashicorp/docker` und `kreuzwerker/docker`. Die Lösung bestand in der eindeutigen Angabe des verwendeten Providers in allen Modulen und im Root-Modul.
- Probleme mit der mehrfachen Definition des Netzwerks. Das wurde gelöst, indem ein gemeinsames `docker_network` im Root-Modul erstellt und per Variable in die Module übergeben wurde.
- Ein Container (die Python-App) beendete sich sofort. Zum Test wurde `command = ["sleep", "3600"]` gesetzt, um den Container aktiv zu halten.

Durch die Nutzung von Variablen, Modulen, Outputs und Locals wurde die Lösung strukturiert und flexibel aufgebaut. Änderungen lassen sich kontrolliert durchführen, und die Wiederverwendbarkeit ist durch die Modularisierung gegeben. Die Lösung erfüllt damit die Anforderungen an eine nicht-triviale, parametrisierte und modulare Terraform-Konfiguration.

Die Arbeit mit Terraform ermöglichte es mir, mich intensiv mit Fehlerquellen, Providerdetails und dem Umgang mit Modulen auseinanderzusetzen. Der deklarative Ansatz von Terraform bietet gegenüber rein skriptbasierten Methoden eine erhebliche Vereinfachung bei gleichzeitiger Wartbarkeit.
