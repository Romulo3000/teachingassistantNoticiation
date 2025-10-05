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