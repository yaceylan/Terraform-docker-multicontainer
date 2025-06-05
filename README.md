# Terraform Projekt: Docker Multi-Container App

## Projektbeschreibung

Dieses Projekt demonstriert die Anwendung von Infrastructure as Code (IaC) mit Terraform. Ziel ist der Aufbau einer lokalen Infrastruktur, bestehend aus mehreren Docker-Containern, über den Docker-Provider (`kreuzwerker/docker`). 

Das Setup umfasst zwei Container:
- Ein Nginx-Container als Reverse Proxy
- Ein Python-App-Container

Beide Container werden über ein gemeinsames Docker-Netzwerk verbunden. Die Infrastruktur ist vollständig mit Terraform konfiguriert, modularisiert und parametrisiert.

## Zielsetzung

Ziel der Aufgabe war es:
- Ein nicht-triviales Terraform-Projekt selbstständig umzusetzen
- Alle zentralen Bausteine (Provider, Ressourcen, Variablen, Outputs, Locals, Module) sinnvoll einzusetzen
- Die Infrastruktur vollständig über Terraform zu verwalten (init, plan, apply, destroy)
- Eine strukturierte und dokumentierte Lösung bereitzustellen