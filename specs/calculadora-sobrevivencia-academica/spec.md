# Feature Specification: Calculadora de Sobrevivencia Academica

**Feature Branch**: `[feature/calculadora-sobrevivencia-academica]`

**Created**: 2026-06-02

**Status**: Ready for Backlog card

**Input**: User description: "Criar uma User Story de teste para validar o harness. Criar a tela inicial baseada no prototipo Stitch. Calculadora de Sobrevivencia Academica: calcular quanto preciso tirar na proxima prova para passar."

## Contexto

A feature cria a tela inicial da "Calculadora de Sobrevivencia Academica", uma calculadora visual para estudantes da UFSC estimarem quanto precisam tirar na proxima avaliacao para passar, verificar frequencia, simular recuperacao e entender seu risco academico.

O objetivo didatico e validar o harness com uma feature pequena, visual, emocionalmente proxima dos alunos e completa o suficiente para exercitar Spec Driven Development, Stitch MCP, testes e avaliacao visual.

## Escopo da User Story

Esta especificacao define uma fatia unica e pequena:

- Tela inicial da calculadora.
- Calculo de nota necessaria na proxima avaliacao.
- Simulacao de recuperacao (REC).
- Campo de frequencia na v1.
- Links/botoes de navegacao futuros visiveis, sem implementacao das rotas.
- Stack alvo React / Next.js.
- Produto organizado como monorepo.

Nao deve haver implementacao de codigo durante `/refine`.

## Referencias

- GitHub Project: https://github.com/users/italomanzine/projects/3/views/1
- Produto alvo: `italomanzine/Alexandria-UFSC`
- Stitch Project: https://stitch.withgoogle.com/projects/13111711788255953460?pli=1
- Stitch node obrigatorio para implementacao: https://stitch.withgoogle.com/projects/13111711788255953460?node-id=6b8e98f1e5ad4c30b717b75f0671b922
- Stitch MCP project: `projects/13111711788255953460`
- Stitch MCP screen obrigatoria: `projects/13111711788255953460/screens/6b8e98f1e5ad4c30b717b75f0671b922`
- Stitch local reference: `.stitch/SITE.md`
- Stitch visual system: `.stitch/DESIGN.md`
- Fonte UFSC PROGRAD: https://prograd.ufsc.br/faq-2/

## Verificacao Stitch MCP

O projeto local possui configuracao do servidor MCP `stitch` em `.mcp.json`, apontando para `https://stitch.googleapis.com/mcp`, e o projeto operacional esta registrado como `projects/13111711788255953460`.

Teste previo realizado em 2026-06-02:

- `initialize`: PASS, servidor respondeu com `capabilities`, `protocolVersion` e `serverInfo`.
- `tools/list`: PASS, ferramentas disponiveis incluem `get_project`, `list_projects`, `list_screens`, `get_screen`, `upload_design_md`, `create_design_system`, `apply_design_system`.
- `get_project` com `name=projects/13111711788255953460`: PASS, retornou projeto `Calculadora de Notas UFSC`, `TEXT_TO_UI_PRO`, `DESKTOP`, `PRIVATE`.
- `list_screens` com `projectId=13111711788255953460`: PASS, retornou a tela principal `projects/13111711788255953460/screens/6b8e98f1e5ad4c30b717b75f0671b922`.
- `get_screen` da tela principal: PASS, retornou `Calculadora de Notas UFSC com REC - Engenharia de Computacao`, screenshot e HTML. Este e o no/tela que a US deve implementar: https://stitch.withgoogle.com/projects/13111711788255953460?node-id=6b8e98f1e5ad4c30b717b75f0671b922
- Download do HTML da tela principal: PASS, confirmou componentes/rótulos como Alexandria UFSC, Grade Curricular, Projetos, Configuracoes, Historico, Simulador, Simulador de Notas, Dados da Disciplina, P1, P2, Adicionar Avaliacao, Simulacao de Recuperacao (REC), Nota da REC, Calcular Resultado, Media Parcial, Criterios UFSC, Aprovacao Direta e Aprovacao apos REC.

Procedimento obrigatorio para `/intent`:

1. Forcar o uso do Stitch MCP antes de qualquer implementacao visual.
2. Confirmar `initialize` no endpoint `https://stitch.googleapis.com/mcp` configurado em `.mcp.json`.
3. Executar `tools/list` e confirmar que `get_project`, `list_screens` e `get_screen` estao disponiveis.
4. Executar `get_project` com `name=projects/13111711788255953460`.
5. Executar `list_screens` com `projectId=13111711788255953460`.
6. Executar `get_screen` para a screen `projects/13111711788255953460/screens/6b8e98f1e5ad4c30b717b75f0671b922`, referente ao no Stitch https://stitch.withgoogle.com/projects/13111711788255953460?node-id=6b8e98f1e5ad4c30b717b75f0671b922 e a tela "Calculadora de Notas UFSC com REC - Engenharia de Computacao".
7. Baixar/inspecionar o HTML ou screenshot retornado pela screen principal para conferir componentes antes de codificar.
8. Registrar no `plan.md` os comandos/ferramentas usados e os componentes confirmados pelo MCP.
9. Somente depois desse preflight MCP, iniciar a implementacao React / Next.js.

Enquanto o MCP nao estiver disponivel na sessao, as fontes operacionais para refinamento sao:

- `.stitch/SITE.md`
- `.stitch/DESIGN.md`
- `https://stitch.withgoogle.com/projects/13111711788255953460?pli=1`

## Regras Academicas UFSC

Com base na FAQ da PROGRAD sobre a Resolucao 017/CUn/97:

- Notas variam de 0,0 a 10,0.
- A nota minima de aprovacao em cada disciplina e 6,0.
- As notas nao devem ser fracionadas aquem ou alem de 0,5.
- Fracoes intermediarias de nota/media sao arredondadas para a graduacao mais proxima; 0,25 e 0,75 arredondam para a graduacao imediatamente superior.
- Na pratica, uma media 5,75 pode arredondar para 6,0 e resultar em aprovacao direta.
- A frequencia minima esperada e 75%.
- Estudante com frequencia suficiente e media semestral entre 3,0 e 5,5 tem direito a nova avaliacao no final do semestre, salvo excecoes previstas para alguns tipos de disciplina.
- Apos recuperacao, a nota final e a media aritmetica entre a media das avaliacoes parciais e a nota da REC.
- Aprovacao apos REC exige nota final minima 6,0.

## Analise do Prototipo Stitch

A tela inicial de referencia e uma experiencia desktop com suporte responsivo para mobile. Elementos esperados:

- Marca "Alexandria UFSC" e contexto "Engenharia de Computacao / UFSC Ararangua".
- Navegacao lateral desktop com itens como "Calculadora", "Grade Curricular", "Projetos" e "Configuracoes".
- Navegacao superior desktop com links como "Disciplinas", "Historico" e "Simulador".
- Navegacao inferior mobile com links como "Home", "Calculadora" e "Perfil".
- Cabecalho "Simulador de Notas" com texto de apoio sobre planejar o semestre e calcular notas para aprovacao.
- Card "Dados da Disciplina" com campo opcional de nome da disciplina.
- Campo de frequencia percentual na tela inicial.
- Lista de avaliacoes com nome da avaliacao, nota de 0 a 10 e peso percentual.
- Avaliacoes iniciais "P1" e "P2", com peso default de 50% cada.
- Acao "Adicionar Avaliacao" e acao de remover linha de avaliacao.
- Secao "Simulacao de Recuperacao (REC)" com campo de nota esperada na REC.
- Acao principal "Calcular Resultado".
- Card "Media Parcial" com valor destacado e status interpretativo.
- Banner de alerta informando quanto tirar na proxima avaliacao e explicando risco/recuperacao.
- Card "Criterios UFSC" exibindo aprovacao direta, arredondamento 5,75 -> 6,0, direito a recuperacao, reprovacao direta e aprovacao apos REC.

## User Scenarios & Testing

### User Story 1 - Simular sobrevivencia academica na tela inicial (Priority: P1)

Como estudante da UFSC, quero informar notas, pesos, frequencia e possivel REC em uma unica tela para saber quanto preciso tirar na proxima avaliacao e entender se estou em rota de aprovacao, recuperacao ou reprovacao.

**Why this priority**: Esta fatia entrega o valor completo da feature de teste do harness sem abrir escopo para outras paginas ou backend.

**Independent Test**: Pode ser testada acessando a tela inicial, preenchendo disciplina, frequencia, avaliacoes e REC, acionando "Calcular Resultado" e verificando os cards de resultado, criterios UFSC e links futuros de navegacao.

**Acceptance Scenarios**:

1. **Dado** que estou na tela inicial da calculadora, **Quando** vejo a estrutura principal, **Entao** devo encontrar marca Alexandria UFSC, cabecalho "Simulador de Notas", formulario de disciplina, lista de avaliacoes, campo de frequencia, secao REC, botao "Calcular Resultado" e card de criterios UFSC.
2. **Dado** que informei notas e pesos de avaliacoes existentes e deixei uma proxima avaliacao sem nota, **Quando** aciono "Calcular Resultado", **Entao** o sistema deve calcular e exibir quanto preciso tirar na proxima avaliacao para alcancar aprovacao direta.
3. **Dado** que informei frequencia menor que 75%, **Quando** calculo o resultado, **Entao** o sistema deve destacar que a frequencia e insuficiente e que a aprovacao por nota nao basta.
4. **Dado** que informei frequencia igual ou maior que 75% e media parcial entre 3,0 e 5,5, **Quando** calculo o resultado, **Entao** o sistema deve informar que ha direito potencial a REC, salvo excecoes da disciplina.
5. **Dado** que informei uma nota esperada na REC, **Quando** calculo o resultado, **Entao** o sistema deve calcular a nota final usando `(media parcial + nota REC) / 2` e indicar aprovacao ou insuficiencia apos REC.
6. **Dado** que a media calculada e 5,75, **Quando** consulto o resultado ou criterios UFSC, **Entao** o sistema deve explicar que 5,75 pode arredondar para 6,0 conforme a regra pratica de arredondamento.
7. **Dado** que estou na tela inicial em desktop ou mobile, **Quando** vejo os links de navegacao futura, **Entao** devo conseguir identificar botoes/links para areas futuras sem que essas rotas precisem estar implementadas nesta US.
8. **Dado** que estou usando teclado, **Quando** navego pelos campos, botoes e links, **Entao** a ordem de foco deve ser compreensivel e os estados de foco devem ser visiveis.

## Edge Cases

- Nota informada menor que 0 ou maior que 10.
- Peso informado menor que 0 ou maior que 100.
- Frequencia informada menor que 0 ou maior que 100.
- Frequencia menor que 75%.
- Soma de pesos diferente de 100%.
- Avaliacao sem nota porque ainda nao ocorreu.
- Todas as avaliacoes ja preenchidas.
- Nenhuma avaliacao pendente para calcular "proxima prova".
- Nota necessaria na proxima avaliacao maior que 10.
- Nota necessaria na proxima avaliacao menor ou igual a 0.
- Media parcial abaixo de 3,0.
- Media parcial entre 3,0 e 5,5.
- Media parcial igual a 5,75.
- Media parcial igual ou superior a 6,0.
- REC informada fora do intervalo de 0,0 a 10,0.

## Requirements

### Functional Requirements

- **FR-001**: O sistema MUST exibir uma tela inicial de calculadora baseada no prototipo Stitch `projects/13111711788255953460`.
- **FR-002**: O sistema MUST permitir informar opcionalmente o nome da disciplina.
- **FR-003**: O sistema MUST permitir informar frequencia percentual na v1.
- **FR-004**: O sistema MUST iniciar com duas avaliacoes editaveis, "P1" e "P2", com pesos default de 50%.
- **FR-005**: O sistema MUST permitir editar nome, nota e peso de cada avaliacao.
- **FR-006**: O sistema MUST permitir adicionar novas avaliacoes.
- **FR-007**: O sistema MUST permitir remover avaliacoes adicionadas ou existentes.
- **FR-008**: O sistema MUST validar notas no intervalo de 0,0 a 10,0.
- **FR-009**: O sistema MUST validar pesos no intervalo de 0 a 100.
- **FR-010**: O sistema MUST validar frequencia no intervalo de 0 a 100.
- **FR-011**: O sistema MUST calcular media parcial ponderada a partir das avaliacoes com nota preenchida.
- **FR-012**: O sistema MUST calcular a nota necessaria na proxima avaliacao pendente para alcancar aprovacao direta.
- **FR-013**: O sistema MUST exibir a media parcial em card de resultado destacado.
- **FR-014**: O sistema MUST exibir uma mensagem interpretativa sobre aprovacao, recuperacao, frequencia insuficiente ou risco de reprovacao.
- **FR-015**: O sistema MUST permitir informar nota esperada na REC.
- **FR-016**: O sistema MUST calcular media final apos REC usando `(media parcial + nota REC) / 2`.
- **FR-017**: O sistema MUST exibir que aprovacao direta exige 6,0 e que 5,75 pode arredondar para 6,0.
- **FR-018**: O sistema MUST exibir que REC se aplica a media entre 3,0 e 5,5 com frequencia suficiente, salvo excecoes da disciplina.
- **FR-019**: O sistema MUST exibir que frequencia minima esperada e 75%.
- **FR-020**: O sistema MUST exibir links/botoes de navegacao futura para secoes como grade curricular, projetos, configuracoes, disciplinas, historico ou perfil, sem exigir implementacao dessas telas nesta US.
- **FR-021**: O sistema MUST manter layout responsivo coerente com desktop e mobile conforme referencia Stitch.
- **FR-022**: O sistema MUST usar hierarquia visual coerente com `.stitch/DESIGN.md`: marca Alexandria UFSC, serif em titulos, Inter em corpo, Public Sans em labels, superficies tonais, azul primario e destaques dourados.
- **FR-023**: O sistema MUST preservar acessibilidade basica com labels visiveis, foco perceptivel, contraste suficiente e alvos de toque adequados.
- **FR-024**: O sistema MUST ser implementado no produto alvo com stack React / Next.js.
- **FR-025**: O sistema MUST ser organizado como monorepo no produto alvo.

### Non-Functional Requirements

- **NFR-001**: A feature MUST ser implementavel como uma unica User Story de harness, sem backend obrigatorio.
- **NFR-002**: A experiencia MUST funcionar sem persistencia de dados entre sessoes.
- **NFR-003**: A tela MUST ser verificavel por testes automatizados e por evidencia visual no PR.
- **NFR-004**: A implementacao MUST executar o preflight Stitch MCP antes de codificar UI, usando `initialize`, `tools/list`, `get_project`, `list_screens` e `get_screen`.
- **NFR-005**: A implementacao MUST atingir 98% de similaridade visual contra a referencia Stitch, considerando estrutura, hierarquia, componentes principais, cores, tipografia e estados principais.
- **NFR-006**: A implementacao MUST respeitar monorepo com app Next.js isolado de pacotes compartilhados quando estes existirem.
- **NFR-007**: A implementacao MUST nao depender de `docs/` como fonte operacional do harness.

### Key Entities

- **Disciplina**: Representa a disciplina simulada; possui nome opcional, frequencia e lista de avaliacoes.
- **Avaliacao**: Representa uma prova, trabalho ou atividade; possui nome, nota opcional e peso percentual.
- **Resultado Academico**: Representa media parcial, nota necessaria, status de aprovacao/REC/reprovacao/frequencia e media final apos REC quando aplicavel.
- **Criterio UFSC**: Representa as regras usadas para interpretar o resultado academico, incluindo media 6,0, arredondamento 5,75, REC e frequencia minima.
- **Link Futuro**: Representa um item de navegacao visivel para evolucao do produto, sem rota funcional obrigatoria nesta US.

## Success Criteria

### Measurable Outcomes

- **SC-001**: O estudante consegue calcular a nota necessaria na proxima avaliacao em uma unica tela.
- **SC-002**: O estudante consegue identificar visualmente media parcial, frequencia e status academico sem abrir outra pagina.
- **SC-003**: O estudante consegue adicionar pelo menos uma avaliacao extra e recalcular o resultado.
- **SC-004**: O estudante consegue simular REC e visualizar se a media final atingiria 6,0.
- **SC-005**: O estudante consegue entender que 5,75 pode arredondar para 6,0.
- **SC-006**: O estudante consegue ver links de navegacao futura sem depender dessas paginas para completar o fluxo principal.
- **SC-007**: A tela implementada tem similaridade visual minima de 98% com o prototipo Stitch para marca, estrutura, campos principais, cards de resultado e criterios UFSC.

## Out of Scope

- Login, perfil real ou autenticacao.
- Persistencia de disciplinas, historico ou semestre.
- Integracao com CAGR, Moodle ou sistemas oficiais da UFSC.
- Validacao automatica de excecoes por tipo de disciplina.
- Implementacao funcional de paginas "Grade Curricular", "Projetos", "Configuracoes", "Disciplinas", "Historico" ou "Perfil".
- Backend, banco de dados ou APIs remotas.
- Implementacao de codigo durante `/refine`.

## Assumptions

- A primeira entrega sera uma tela inicial funcional, sem backend.
- O usuario alvo e estudante de graduacao da UFSC, especialmente Engenharia de Computacao em Ararangua.
- A regra academica oficial usada para calculo e media final minima 6,0 com frequencia minima 75%.
- O arredondamento de 5,75 para 6,0 deve ser exibido como criterio pratico na UI.
- A regra de REC deve ser apresentada como condicional a frequencia suficiente e as excecoes previstas pela UFSC.
- O produto alvo usara React / Next.js em monorepo.
- O prototipo Stitch e a principal referencia visual da feature.
- Durante `/intent`, o executor deve forcar o carregamento e uso do Stitch MCP antes de implementar a UI, registrar o preflight em `plan.md` e somente entao iniciar codigo visual.
