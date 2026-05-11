# techchallengefase5-hackaton-infra-sqs
Repositório pertencente à fase 5 do Tech Challenge Fiap

Provisiona as filas `requested-analysis` e `requested-report`, suas DLQs e a policy que permite ao bucket `techchallenge-fase5-raw` publicar eventos `ObjectCreated` na fila `requested-analysis`.

Para o fluxo ponta a ponta funcionar automaticamente depois do PUT no S3:
- este repo precisa aplicar a policy SQS;
- o repo `techchallengefase5-hackaton-infra-s3-ecr` precisa aplicar a notificação S3 apontando para `requested-analysis`.
