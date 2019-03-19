| Uso de Recurso | Tarefa | Tamanhos de Arquivo | Comentário |
|-|-|-|-|
| Memory-bound | Extração/descritiva | [5GB, 10GB, 50GB] | Um código com um numero relativamente grande de joins e groupBy, pra que possamos verificar o comportamento do cluster em atividades com bastante uso de memória e shuffle. |
| CPU-Bond | AtyImo | [5GB, 10GB, 50GB] | Um código capaz de usar todo o poder de processamento da fatia de recursos disponibilizada. Certamente levará dias em bases relativamente grandes. |
|-|-|-|-|
| Memory-bound | Agrupamento | 5GB | Codigo com um agrupamento da variável `var`. Tempo de execução: `Tempo`. Status: `status`. |
