Feature: Indicação do status de notificação de cada aluno

        Como professor responsável por uma turma
        Eu quero visualizar o status de notificação de cada aluno, identificando se falta alguma nota
        Para que eu possa acompanhar rapidamente as pendências e notificar alunos com avaliações incompletas

    Scenario: Exibir status para um aluno novo sem notas
    Given o aluno "João Vasconcelos" foi recém-cadastrado na turma "Engenharia de Software 2025.2"
    And ele não possui nenhuma nota lançada
    When eu acesso a página "Notas da Turma"
    Then eu devo ver um indicador de status "Pendente" ao lado do nome de "João Vasconcelos"

    Scenario: O status do aluno é atualizado após o lançamento da última nota pendente
    Given o aluno "Pedro Alves" possui um indicador de status "Pendente"
    And a única nota que lhe falta é para a meta de aprendizado "Especificar requisitos com qualidade"
    When eu lanço a nota "MA" para o aluno "Pedro Alves" na meta "Especificar requisitos com qualidade"
    Then o indicador de status ao lado do nome de "Pedro Alves" deve mudar de "Pendente" para "Completo"

    Scenario: Falha ao atualizar o status do aluno devido a erro no servidor
    Given o aluno "Beatriz Souza" possui o status "Pendente"
    And o servidor apresenta uma falha ao tentar registrar a última nota
    When eu lanço a nota "MPA" para "Beatriz Souza" na meta "Especificar requisitos com qualidade"
    Then o sistema deve exibir uma mensagem "Erro ao atualizar status do aluno"
    And o indicador de status deve permanecer como "Pendente"

    Scenario: Falha ao atualizar o status de mais de um aluno simultaneamente
    Given os alunos "Rafaela Souza" e "Caio Andrade" estão com status "Pendente"
    And o servidor retorna erro ao processar múltiplas atualizações
    When eu tento lançar as notas pendentes de ambos ao mesmo tempo
    Then o sistema deve exibir a mensagem "Erro ao atualizar múltiplos alunos"
    And os status de "Rafaela Souza" e "Caio Andrade" devem permanecer como "Pendente"
    And o sistema deve registrar o erro no log de notificações

    Scenario: O sistema não altera o status do aluno ao tentar registrar uma nota inválida
    Given o aluno "Rogério Melo" está com status "Pendente"
    And possui uma nota pendente na meta "Especificar requisitos com qualidade"
    When eu tento lançar uma nota inválida "XYZ" para essa meta
    Then o sistema deve exibir uma mensagem "Nota inválida — operação cancelada"
    And o status do aluno "Rogério Melo" deve permanecer como "Pendente"

    Scenario: Exibir status de notas completas
    Given a turma "Engenharia de Software 2025.2" possui as metas de aprendizado "Entender conceitos de requisitos" e "Especificar requisitos com qualidade"
    And a aluna "Maria Silva" possui notas para "Entender conceitos de requisitos" e "Especificar requisitos com qualidade"
    When eu acesso a pagina "Notas da Turma"
    Then eu devo ver um indicador de status "Completo" ao lado do nome de "Maria Silva"
 