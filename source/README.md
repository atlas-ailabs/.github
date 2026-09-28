# Fontes das imagens da página

As imagens de `profile/assets/` são geradas a partir destes arquivos HTML. Para mudar um texto ou uma cor, edite o HTML aqui e gere as imagens de novo; não edite os PNGs.

| Arquivo | Imagens | Bloco da página |
|---|---|---|
| `banner.html` | `banner-*.png` | Faixa do topo |
| `intro.html` | `intro-*.png` | Apresentação da Atlas |
| `card.html` | `service-1..3-*.png` | Cartões de "O que fazemos" (os textos das três frentes ficam na lista `D`, dentro do arquivo) |
| `process.html` | `process-*.png` | Linha do tempo de "Como trabalhamos" |
| `closing.html` | `closing-*.png` | Fechamento "Vamos conversar" |
| `base.css` | — | Cores e estilos comuns aos cartões (o tema claro fica em `body.light`) |

Cada página abre em tema escuro; com `#light` no fim do endereço, abre em tema claro. As fontes (Space Grotesk e IBM Plex Mono) vêm do Google Fonts, então a geração precisa de internet.

## Gerar as imagens

```bash
source/render.sh
```

O script precisa de um Chromium: o do Playwright (`npx playwright install chromium-headless-shell`), o Google Chrome instalado, ou o caminho em `CHROME=/caminho/do/chrome`. As imagens publicadas foram geradas com o do Playwright; o Google Chrome dá o mesmo resultado, só com diferenças de suavização nas bordas. Ele grava as imagens em 2× (2560 px de largura) em `profile/assets/`, nos dois temas.

Quando mudar um texto, atualize também o `alt` da imagem em `profile/README.md`: é ele que leitores de tela e buscadores leem.
