Feature: Status Visual de Notas Pendentes

AS A professor
I WANT TO ver um indicador visual ao lado do nome de cada aluno na lista da turma
SO THAT eu possa identificar rapidamente quais alunos tem notas pendentes e quais ja estao com todas as notas lancadas

Scenario: Exibir status de notas completas
  Given a turma "Engenharia de Software 2025.2" possui as metas de aprendizado "Entender conceitos de requisitos" e "Especificar requisitos com qualidade"
  And a aluna "Maria Silva" possui notas para "Entender conceitos de requisitos" e "Especificar requisitos com qualidade"
  When eu acesso a pagina "Notas da Turma"
  Then eu devo ver um indicador de status "Completo" ao lado do nome de "Maria Silva"

Scenario: Exibir status de notas pendentes
  Given a turma "Engenharia de Software 2025.2" possui as metas de aprendizado "Entender conceitos de requisitos" e "Especificar requisitos com qualidade"
  And o aluno "Pedro Alves" possui nota para "Entender conceitos de requisitos", mas nao possui nota para "Especificar requisitos com qualidade"
  When eu acesso a pagina "Notas da Turma"
  Then eu devo ver um indicador de status "Pendente" ao lado do nome de "Pedro Alves"

Scenario: O status retorna para pendente após uma nota ser removida
  Given a aluna "Maria Silva" possui um indicador de status "Completo"
  And ela possui notas para todas as metas de aprendizado da turma
  When eu removo a nota da aluna "Maria Silva" na meta "Especificar requisitos com qualidade"
  Then o indicador de status ao lado do nome de "Maria Silva" deve mudar de "Completo" para "Pendente"

Scenario: O status de um aluno completo muda para pendente quando uma nova meta é adicionada à turma
  Given a aluna "Maria Silva" possui um indicador de status "Completo"
  And a turma possui apenas as metas de aprendizado "Entender conceitos de requisitos" e "Especificar requisitos com qualidade"
  When eu adiciono a nova meta de aprendizado "Entender conceitos de gerência de configuração" à turma
  Then o indicador de status ao lado do nome de "Maria Silva" deve mudar de "Completo" para "Pendente"

Scenario: Exibir status quando a turma não possui metas de aprendizado
  Given a aluna "Ana Leticia" está cadastrada na turma "Engenharia de Software 2025.2"
  And a turma "Engenharia de Software 2025.2" não possui nenhuma meta de aprendizado definida
  When eu acesso a página "Notas da Turma"
  Then eu devo ver um indicador de status "N/A" (Não Aplicável) ao lado do nome de "Ana Leticia"

Scenario: O status de um aluno pendente muda para completo quando uma meta é removida
  Given o aluno "Pedro Alves" possui um indicador de status "Pendente"
  And a única nota que lhe falta é para a meta de aprendizado "Entender conceitos de gerência de configuração"
  When eu removo a meta de aprendizado "Entender conceitos de gerência de configuração" da turma
  Then o indicador de status ao lado do nome de "Pedro Alves" deve mudar de "Pendente" para "Completo"