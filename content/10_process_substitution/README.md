# _Process substitution_

Imagine que você deseja obter, do arquivo `/usr/share/dict/words`, todas as palavars que contém o caractere **d**. Para isso, tem-se:

```bash
grep d /usr/share/dict/words
```

Imagine, agora, que desejamos saber a quantidade de palavras que contém o caractere **d** nesse mesmo arquivo. Pode-se executar:

```bash
grep -c d /usr/share/dict/words
```

Podemos fazer isso utilizando laços de repetição em _Bash_. Como em:

```bash
#!/bin/bash

words=$(grep d /usr/share/dict/words)

i=0
for word in $words; do
    echo $word
    ((i++))
done

echo "$i palavra(s) foi(foram) encontrada(s)"
```

Perceba que o resultado de `grep d /usr/share/dict/words` precisou ser **todo** carregado em memória para só então ser alvo da iteração do laço `for`.

A questão aqui é que quaisquer outras tentaivas "convencionais', seja usando **for** ou usando **while**, resulta nesse mesmo problema de eficiência.

Existe, no entanto, uma forma de carregar o `grep` ao passo em que a iteração é construída. Para isso, utiliza-se o recurso de **process substitution**.

## Sintaxe

A sintaxe é parecida com a de _command substitution_. No entanto, ao contrário de `$`, utiliza-se `<` para _input_ e `>` para _output_.

```bash
<(command) # input
>(command) # output
```

## Funcionamento

A ideia é que o resultado do processo dentro dos parânteses seja tratado como um arquivo, geralmente armazenado em `/dev/fd/` a partir de um _file descriptor_.

Ou seja, quando utilizamos esse recurso aliado a um laço de repetição, não é preciso esperar que o processo referido dentro dos parênteses seja totalmente concluído para que a iteração de fato começe.

## Exemplo

Segue um exemplo da contagem das palavras que contém o caractere **d** utilizando _process substitution_.

```bash
#!/bin/bash

i=0
while read -r word; do
    echo $word
    ((i++))
done < <(grep d /usr/share/dict/words)

echo "$i palavra(s) foi(foram) encontrada(s)"
```

A principal vantagem é em relação a **não dependência em relação à performance do comando/processo entre parênteses**.
