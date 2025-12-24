# Flutter Shopping Cart - MVVM Architecture

Desafio técnico de um aplicativo de carrinho de compras consumindo a FakeStoreAPI, seguindo os padrões de arquitetura MVVM e Clean Architecture.

## 🚀 Tecnologias e Requisitos
- **Flutter 3.32.0 • channel stable** / **Dart Dart 3.8.0**
- **Gerenciamento de Estado:** ChangeNotifier (Provider)
- **Navegação:** Rotas nomeadas (Nativa)
- **Arquitetura:** MVVM + Clean Architecture Layers

## 🏗️ Arquitetura
O projeto segue uma estrutura modularizada e dividida em camadas para garantir a separação de responsabilidades:

1. **Domain:** Contém as entidades puras, contratos (interfaces) de repositórios e Casos de Uso (UseCases). É a camada mais interna e sem dependências externas.
2. **Infra (Data):** Implementação dos repositórios, modelos (DTOs) para serialização JSON e serviços de API.
3. **Modules (Presentation):** Onde reside o padrão MVVM. 
   - **View:** Widgets e Pages que reagem ao estado.
   - **ViewModel:** Gerencia o estado da UI e orquestra os UseCases.
4. **Shared:** Código compartilhado como temas, utilitários e widgets globais.

## 🛠️ Como rodar o projeto
1. Certifique-se de ter o Flutter instalado na versão 3.x.
2. Clone o repositório.
3. Execute `flutter pub get` na raiz do projeto.
4. Execute `flutter run`.

