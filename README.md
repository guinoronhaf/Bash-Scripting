# Bash Scripting

## Conceitos iniciais

_Bash script_ é muito útil principalmente no que tange a automatização de tarefas repetitivas e tratamento de grandes volumes de arquivos com Linux.

## _Shebang_

_Shebang_, ou simplesmente *#!*, é uma sequência de caracteres que permite identificar o programa que irá interpretas o código em shell script. Por exemplo:

```bash
# script.sh
#!/bin/bash

echo "hello, world!"
```

define o _bash_ como interpretador padrão do código.

Assim, ao invés de executar `bash script.sh`, basta alterar as permissões do arquivo e executá-lo como qualquer outro executável.

```bash
chmod +x script.sh; ./script.sh
```

## Redirecionando outputs

Para redirecionar resultados de comando para arquivos, basta executar:

```bash
echo "teste" > file.txt # reescreve o conteúdo
```

```bash
echo "teste" >> file.txt # adiciona ao que já existia
```

## Condições

```bash
#!/bin/bash

count=10

if [ $count -gt 10 ]; then
    echo "the condition is true"
else
    echo "the condition is false"
fi
```

Alguns operadores importantes:

 - `eq`: **equal**
 - `ne`: **not equal**
 - `gt`: **greaten than**
 - `lt`: **less then**
 - `ge`: **greater or equal**
 - `le`: **less or equal**

É possível, naturalmente, utilizar os símbolos de operadores matemáticos, mas a sintaxe muda um pouco:

```bash
#!/bin/bash

count=10

if (( $count > 10 )) then
    echo "the condition is true"
else
    echo "the condition is false"
fi
```

### if/else-if _statements_

```bash
#!/bin/bash

count=10

if [ $count -lt 10 ]; then
    echo "the condition is true"
elif [ $ count -lt 15]; then
    echo "the condition is half true"
else
    echo "the condition is false"
fi
```

## Logical operators

### _and_(&&, -a)

```bash
#!/bin/bash

age=10

if [ "$age" -gt 10 ] && [ "$age" -gt 20]; then
    echo "greater than 10 and greater than 20"
else
    echo "false"
fi
```

Importante destacar que, em _Bash Script_, os operadores de comparação (gt, lt, ge,...) devem ser usados único e exclusivamente com inteiros. Isso justifica o fato de `"$age" > 10` funcionar quando parece que `age` vai ser convertida para String.

Nesse caso, o interpretador converte o valor de `age` para inteiro.

Naturalmente, pode-se perfeitamente unificar as duas condições separadas em uma só. No entanto, apenas um ajuste de sintaxe é necessário.

```bash
#!/bin/bash

age=10

if [[ "$age" -gt 10 && "$age" -gt 20 ]]; then
    echo "greater than 10 and greater than 20"
else
    echo "false"
fi
```

Caso seja preferível utlizar apenas um par de colchetes, basta usar a _flag_ `-a`:

```bash
#!/bin/bash

age=10

if [ "$age" -gt 10 -a "$age" -gt 20 ]; then
    echo "greater than 10 and greater than 20"
else
    echo "false"
fi
```

### _or_(-o)

```bash
#!/bin/bash

age=10

if [ "$age" -gt 10 || "$age" -gt 20 ]; then
    echo "greater than 10 and greater than 20"
else
    echo "false"
fi
```

Assim como o _and_, é possíve dispensar o par de colchetes a partir do uso de uma _flag_ `-o`:

```bash
#!/bin/bash

age=10

if [ "$age" -gt 10 -o "$age" -gt 20 ]; then
    echo "greater than 10 and greater than 20"
else
    echo "false"
fi
```
