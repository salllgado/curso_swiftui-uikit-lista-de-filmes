# MovieList

> Aplicativo de exemplo desenvolvido como conteúdo de curso.

📽️ **Descrição**

MovieList é um aplicativo iOS que consome a API do The Movie Database (TMDB) para exibir uma lista de filmes, detalhes e uma tela de busca. O projeto é usado como material didático para demonstrar integração com API, arquitetura simples usando **MVVM** com **async/await**, padrão delegate, e composição de interfaces com **UIKit** e **SwiftUI** usando o visual ***Liquid Glass***.

---

## ✨ Principais funcionalidades
- Tela de **listagem** de filmes (feed com paginação)
- Tela de **detalhes** do filme (sinopse, pontuação, imagens)
- Tela de **busca** por título
- Componentes híbridos com **UIKit + SwiftUI**
- Estrutura modular (Scenes, Network, Models, Components)
- Utilização de módulos usando *Swift Package Manager*
---

## 🧰 Tecnologias
- Linguagem: **Swift**
- UI: **UIKit** + **SwiftUI**
- Estilo: **Liquid Glass**
- Requisitos: **iOS 26 / iPadOS 26**, **Xcode 26**
- API: **The Movie Database (TMDB)**

---

## 🚀 Como executar

1. Clone o repositório:

```bash
git clone <url-do-repo>
```

2. Abra o workspace no Xcode:

```bash
open MovieList.xcworkspace
```

3. Adicione sua API Key do TMDB:

Opções recomendadas:

- Criar um arquivo `Secrets.plist` (adicionado ao `.gitignore`) contendo `TMDB_API_KEY`.
- Ou configurar variável de ambiente `TMDB_API_KEY` e ler a partir do código.

Exemplo de `Secrets.plist` (não comite):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>TMDB_API_KEY</key>
  <string>COLOQUE_SUA_API_KEY_AQUI</string>
</dict>
</plist>
```

4. Selecione um simulador com iOS 26 e rode o projeto no Xcode.

> ⚠️ Importante: nunca inclua sua **TMDB API Key** em commits públicos. Use `.gitignore` para arquivos de configuração locais.

---

## 🗂 Estrutura do projeto

- `App/` — AppDelegate, SceneDelegate e configurações do app
- `Scenes/MainList/` — Tela principal, ViewModel e células (`MainListViewController`, `MainListViewModel`, `MovieUITableViewCell`)
- `Network/` — `API.swift`, `NetworkManager.swift` e rotas (`APIMethod.swift`)
- `Models/` — Modelos (`Movies.swift`)
- `Components/` — Views reutilizáveis (`MovieCellView.swift`)

---

## 🔧 Como contribuir
- Abra uma issue para discutir a proposta
- Faça fork → nova branch → PR descrevendo as mudanças
- Não comite chaves/segredos
---

## ⚖️ Licença

Sugerimos **MIT License**. Se desejar, crie um arquivo `LICENSE` na raiz do repositório.

---

## Créditos

- Dados e imagens: **The Movie Database (TMDB)** (verifique e respeite os termos de uso da TMDB)
