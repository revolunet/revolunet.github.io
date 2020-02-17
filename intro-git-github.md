# Introduction Git

- Git : gestion de versions de fichiers décentralisé (CLI)
- GitHub/GitLab : surcouches web pour collaborer autour de projets GIT

Cela peut être utile pour de la collaboration sur [du code](https://code.etalab.gouv.fr/fr/repos), de la [documentation](https://github.com/elastic/docs), des [datasets](https://github.com/fanzeyi/pokemon.json), des [icônes](https://github.com/FortAwesome/Font-Awesome), des [données cartos](https://github.com/simonepri/geo-maps) ou... toute sorte de fichier pas trop gros et au format texte si possible.

## GIT, kezako

GIT historise tous les changements donc n'aies pas peur de détruire quelque chose !

![](https://i.imgur.com/JO9x1WF.png)

#### Vocabulaire

# Introduction Git

- Git : gestion de versions de fichiers décentralisé (CLI)
- GitHub/GitLab : surcouches web pour collaborer autour de projets GIT

C'est' utile pour de la collaboration sur [du code](https://code.etalab.gouv.fr/fr/repos), de la [documentation](https://github.com/elastic/docs), des [datasets](https://github.com/fanzeyi/pokemon.json), des [icônes](https://github.com/FortAwesome/Font-Awesome), des [données cartos](https://github.com/simonepri/geo-maps) ou... toute sorte de fichier pas trop gros et au format texte (si possible).

## GIT, kezako

GIT historise tous les changements donc n'aies pas peur de détruire quelque chose !

![](https://i.imgur.com/JO9x1WF.png)

#### Vocabulaire

- **clone** : copier un projet
- **commit** : enregistremer des modifications
- **branch** : version parallèle du projet qui pourra être réintégrée
- **merge/rebase** : intégrer les changes d'une branche dans une autre branche
- **push/pull** : synchroniser ses modifs sur un serveur distant (ex: github)
- **diff** : differences d'un commit à l'autre sur n fichiers

![](https://i.imgur.com/1jrfQWR.png)

💡 Par convention la branche par défaut est `master`
👉 [exemple de diff](https://github.com/SocialGouv/code-du-travail-numerique/pull/2350/files)
👉 créer un compte sur [GitHub](https://github.com)
💪 apprendre le CLI GIT : try.github.com

### GitHub, GitLab

Interfaces web par-dessus GIT avec des fonctionnalités en plus :

- gestion de projets et d'équipes
- API, sécurité
- CI/CD, webhooks, intégrations diverses

Et une couche "sociale" qui permet d'explorer les écosystèmes open-source.

![](https://i.imgur.com/a9PDIRS.png)

#### Vocabulaire

- convention du [**README.md**](https://github.com/SocialGouv/code-du-travail-numerique/blob/master/README.md)
- **Repository** : projet
- **Issues** : gestion des tickets
- **Milestones** : organisation en sprints
- **Projets** : Kanban boards
- **Pull request** aka **PR** : demande de merge de branche
- **Markdown** : format structuré de texte brut
- **wiki**, **releases**, **changelogs**
- **CI/CD** : pipelines pour tester et déployer des scripts ou environnements

Sur GitHub ou GitLab, les **repositories** sont regroupés par `username` (github.com/ivangabriele/dumdum) ou par `organisation`(github.com/SocialGouv/ui-core) et peuvent être publics ou privés.

👉 [exemple de PR](https://github.com/SocialGouv/code-du-travail-numerique/pull/963)
👉 [exemples de milestones](https://github.com/SocialGouv/code-du-travail-numerique/milestones?state=closed)
👉 [exemples de kanban](https://github.com/ansible/ansible/projects/27)
👉 s'entrainer au markdown sur hackmd.io

## Utiliser GitHub pour collaborer

### Issues

#### Gestion des issues dans GitHub

- créer une [issue actionnable](https://github.com/betagouv/demarches-simplifiees.fr/wiki/Comment-%C3%A9crire-une-bonne-issue)
- gestion des tags, assignations, milestones ou projets
- gestion markdown, fichiers, liens, screenshots...
- 💡 NB: GitLab est plus avancé côté gestion de projet

#### Workflow basique :

- **sprint planning** : définir le contenu de du prochain sprint
  - Lea PO séléctionne les issues à traiter et les priorise (avec l'équipe)
  - Les devs s'attribuent les issues petit à petit
- **sprint**: traitement des issues en continu avec des PR
  - Chaque PR permet de clôre une issue
  - Les PR permettent des **itérations courtes** (preview, corrections, review) avec des environnements de preview
  - Une PR validée finit dans la branche **master** (et un nouvel env)
- **demo** : review de la branche master pour envoi en production
- La **CI/CD** automatise les releases et déploiements

💡 Plusieurs workflow GIT existent selon la taille de l'équipe, le type de projet...

👉 Pouvoir lier les infos métier et le code permet de tracer tout l'historique d'un projet, de partager et capitaliser sur la connaissance, d

### Milestones

> Distribuer les tâches, rythmer le projet

## Hands-on : créer du contenu

#### Editer le standup

Proposes une modification sur https://github.com/SocialGouv/standup

#### Editer le site de l'incubateur

Proposes une modification sur https://github.com/SocialGouv/socialgouv.github.io

#### Créer un site web avec du markdown directement sur GitHub.com

GitHub et GitLab permettent d'héberger gratuitement des pages **statiques** (HTML, CSS, JavaScript). Idéal pour un site web de présentation.

Pour GitHub c'est le système de [GitHub Pages](https://help.github.com/en/github/working-with-github-pages). On peut servir soit un dossier de notre **repo** soit utiliser **jekyll** pour générer un site à partir de nos sources en **markdown**.

Pour créer un site exposé sur username.github.io:

- Créé un nouveau répo sur github.com/username/username.github.io
- Active les Github Pages : aller dans les settings du projet
- Choisit un template jekyll
- Crées des fichiers markdown

👉 [Aller plus loin avec GitHub Pages](https://help.github.com/en/github/working-with-github-pages)

## Outils

- try.github.com : apprendre le CLI de GIT (important pour comprendre les concepts)
- GitHub explore : https://github.com/explore
- hackmd.io : créer du contenu markdown en mode collaboratif
- markdownguide.org : tout sur le markdown
- [LiceCap](https://www.cockos.com/licecap) : créer des captures d'écran en GIF animé pour les changelogs
- **clone** : copier un projet
- **commit** : enregistremer des modifications
- **branch** : version parallèle du projet qui pourra être réintégrée
- **merge/rebase** : intégrer les changes d'une branche dans une autre branche
- **push/pull** : synchroniser ses modifs sur un serveur distant (ex: github)
- **diff** : differences d'un commit à l'autre sur n fichiers

![](https://i.imgur.com/1jrfQWR.png)

💡 Par convention la branche par défaut est `master`
👉 [exemple de diff](https://github.com/SocialGouv/code-du-travail-numerique/pull/2350/files)
👉 créer un compte sur [GitHub](https://github.com)
💪 apprendre le CLI GIT : try.github.com

### GitHub, GitLab

Interfaces web par-dessus GIT avec des fonctionnalités en plus :

- gestion de projets et d'équipes
- API, sécurité
- CI/CD, webhooks, intégrations diverses

Et une couche "sociale" qui permet d'explorer les écosystèmes open-source.

![](https://i.imgur.com/a9PDIRS.png)

#### Vocabulaire

- convention du [**README.md**](https://github.com/SocialGouv/code-du-travail-numerique/blob/master/README.md)
- **Repository** : projet
- **Issues** : gestion des tickets
- **Milestones** : organisation en sprints
- **Projets** : Kanban boards
- **Pull request** aka **PR** : demande de merge de branche
- **Markdown** : format structuré de texte brut
- **wiki**, **releases**, **changelogs**
- **CI/CD** : pipelines pour tester et déployer des scripts ou environnements

Sur GitHub ou GitLab, les **repositories** sont regroupés par `username` (github.com/ivangabriele/dumdum) ou par `organisation`(github.com/SocialGouv/ui-core) et peuvent être publics ou privés.

👉 [exemple de PR](https://github.com/SocialGouv/code-du-travail-numerique/pull/963)
👉 [exemples de milestones](https://github.com/SocialGouv/code-du-travail-numerique/milestones?state=closed)
👉 [exemples de kanban](https://github.com/ansible/ansible/projects/27)
👉 s'entrainer au markdown sur hackmd.io

## Utiliser GitHub pour collaborer

### Issues

#### Gestion des issues dans GitHub

- créer une [issue actionnable](https://github.com/betagouv/demarches-simplifiees.fr/wiki/Comment-%C3%A9crire-une-bonne-issue)
- gestion des tags, assignations, milestones ou projets
- gestion markdown, fichiers, liens, screenshots...
- 💡 NB: GitLab est plus avancé côté gestion de projet

#### Workflow dev/métier basique :

- **sprint planning** : définir le contenu de du prochain sprint
  - Lea PO séléctionne les issues à traiter et les priorise (avec l'équipe)
  - Les devs s'attribuent les issues petit à petit
- **sprint**: traitement des issues en continu avec des PR
  - Chaque PR permet de clôre une issue
  - Les PR permettent des **itérations courtes** (preview, corrections, review) avec des environnements de preview
  - Une PR validée finit dans la branche **master** (et un nouvel env)
- **demo** : review de la branche master pour envoi en production
- La **CI/CD** automatise les releases et déploiements

💡 Plusieurs workflow GIT existent selon la taille de l'équipe, le type de projet...

👉 Pouvoir lier les infos métier et le code permet de tracer tout l'historique d'un projet, de partager et capitaliser sur la connaissance, d

### Milestones

> Distribuer les tâches, rythmer le projet

## Hands-on : créer du contenu

#### Editer le standup

Proposes une modification sur https://github.com/SocialGouv/standup

#### Editer le site de l'incubateur

Proposes une modification sur https://github.com/SocialGouv/socialgouv.github.io

#### Créer un site web avec du markdown directement sur GitHub.com

GitHub et GitLab permettent d'héberger gratuitement des pages **statiques** (HTML, CSS, JavaScript). Idéal pour un site web de présentation.

Pour GitHub c'est le système de [GitHub Pages](https://help.github.com/en/github/working-with-github-pages). On peut servir soit un dossier de notre **repo** soit utiliser **jekyll** pour générer un site à partir de sources en **markdown**.

- Créé un nouveau répo sur github.com/username/username.github.io
- Active les Github Pages : aller dans les settings du projet
- Choisit un template jekyll
- Crées des fichiers markdown

👉 [Aller plus loin avec GitHub Pages](https://help.github.com/en/github/working-with-github-pages)

## Outils

- try.github.com : apprendre le CLI de GIT (important pour comprendre les concepts)
- GitHub explore : https://github.com/explore
- hackmd.io : créer du contenu markdown en mode collaboratif
- markdownguide.org : tout sur le markdown
- [LiceCap](https://www.cockos.com/licecap) : créer des captures d'écran en GIF animé pour les changelogs
