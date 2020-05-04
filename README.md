# Stam Acasa

**Stam Acasa** este o aplicatie pentru Android si IOS care are ca scop (auto)evaluarea simptomelor pentru a determina 
daca exista sau nu o infectie cu virusul SARS-CoV-2. Informatiile de mai jos se refera la versiunea pentru IOS a aplicatiei.


## 1. Aplicatia

Aplicatia ruleaza pe orice dispozitiv cu sistemul de operare Android si stocheaza local datele introduse pentru evaluare. Evaluarea
se face - pentru flexibilitate si a nu necesita actualizare - printr-un apel trimis catre server, unde exista implementat si modelul 
clinic pentru diagnostic Covid-19.

In sectiunea [**Releases**](https://github.com/covid-ro/stamacasa-app-ios/releases) exista versiunile compilate (debug) ale 
aplicatiei demo.

**Atentie**: Instalarea aplicatiei (distributie demo ca fisier IPA in sectiunea Releases) se face prin dezarhivarea fisierului cu 
release-ul pe un server cu HTTPS si apoi incarcarea in browserul Safari de pe deispozitivul Apple a URL de pe server, acolo unde 
a fost dezarhivata arhiva. Va trebui modificat si fisierul `.plist` din arhiva pentru a contine link-ul catre IPA.


## 2. Screenshots

Nu exista, momentan.


## 3. Modificari; versiuni; TODO

#### [1.0.0] - 2020-04-30
Versiunea initiala a aplicatiei pentru IOS.

### TODO
- [ ] Obtinere lista intrebari pentru chestionarul de evaluare de pe server
