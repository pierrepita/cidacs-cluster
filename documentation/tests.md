| Uso de Recurso | Tarefa | Tamanhos de Arquivo | Comentário |
|-|-|-|-|
| *Memory-bound* | *Extração/descritiva*| *[5GB, 10GB, 50GB]* | *Um código com um numero relativamente grande de joins e groupBy, pra que possamos verificar o comportamento do cluster em atividades com bastante uso de memória e shuffle.* |
| *CPU-Bond* | *AtyImo* | *[5GB, 10GB, 50GB]* | *Um código capaz de usar todo o poder de processamento da fatia de recursos disponibilizada. Certamente levará dias em bases relativamente grandes.* |
|||||
| Memory-bound | Agrupamento | 5GB | Codigo com o agrupamento de todas as colunas do banco. Tempo de execução: `3 minutos`. Status: `sucesso`. |
| Memory-bound | Agrupamento | 10GB | Codigo com o agrupamento de todas as colunas do banco. Tempo de execução: `6 minutos`. Status: `sucesso`. | 
| Memory-bound | Agrupamento | 50GB | Codigo com o agrupamento de todas as colunas do banco. Tempo de execução: `28 minutos`. Status: `sucesso`. | 
| Memory-bound | Concorrencia | 10GB | Codigo com o agrupamento de todas as colunas do banco rodando 6x, em dois usuários diferentes, 3 execuções por usuário. Tempo de execução: `28 minutos`. Status: `status`. |
