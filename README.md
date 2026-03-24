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

## Indexed arrays (arrays indexados)

A estrutura básica para a criação de um array em _bash_ é:

```bash
array=(foo bar baz)
```

Pode-se, naturalmente, realizar diversas operações sobre esse array:

```bash
echo "$array" # -> foo (ou seja, se tratar o array inteiro como uma variável, obtém-se apenas o primeiro elemento)
echo "${array[0]}" # -> foo
echo "${array[1]}" # -> bar
echo "${array[2]}" # -> baz
echo "${array[3]}" # ->
```

Em se tratando de índices, o que ocorre em _bash_ é similar a Python. Por exemplo, tem-se:

```bash
echo "${array[-1]}" # -> baz
```

Naturalmente, é possível substituir os índices numéricos por variáveis que os referenciem. Por exemplo:

```bash
idx=2
echo "${array[$idx]}" # -> baz
```

Nesses casos, pode-se ainda optar por não tratar `idx` como uma "variavel clássica" de _Bash_, omitindo o `$`.

```bash
idx=2
echo "${array[idx]}" # -> baz
```

### Explorando múltiplos itens do array

Inicialmente, caso busque-se obter todos os itens do array em sequência, pode-se usar tanto `*` quanto `@` (já usado como `$@`) para obter todos os argumentos passados durante a execução de um arquivo.

```bash
echo "${array[*]}" # -> foo bar baz
echo "${array[@]}" # -> foo bar baz
```

No entanto, existe uma diferença fundamental em relação a esses dois símbolos:

 - `*`: usado quando o propósito é de tratar o array como uma única _string_;
 - `@`: utilizado quando deseja-se **iterar** pelos itens do _array_.

> [!WARNING]
> Se procurar mais a fundo nas documentações por aí, você vai ver que se retirar as aspas duplas ("") e usar `*`, você consegue, **A PRINCÍPIO**, iterar pelo _array_. Mas isso não é verdade. Tente adicionar um elemento do tipo _string_ formado por várias palavras ao _array_ e veja o que acontece quando você itera com `*` e sem aspas duplas.

Aqui vai um exemplo. Se tentarmos iterar pelos itens do array usando `*`, tem-se:

```bash
for item in "${array[*]}"; do
    echo $item
done

# -> foo bar baz
```

Se usarmos `@`, no entanto:

```bash
for item in "${array[@]}"; do
    echo $item
done

# -> foo
# -> bar
# -> baz
```

### Criando _arrays_

Existe mais de uma forma de criar/declarar _arrays_ em Bahs. Pode-se simplesmente utilizar a sintaxe padrão que utilizamos até agora, OU pode-se usar o comando `declare` seguido da flag `-a`:

```bash
declare -a array=(
    foo
    bar
    baz
)
```

Pode-se ainda, ao utilizar **declare**, declarar a variável antes e só depois **inicializá-la**:

```bash
declare -a array
array=(
    foo
    bar
    baz
)
```

### Copiando _arrays_

De início, o que pode se tentar fazer é simplesmente:

```bash
first_array=(foo bar baz)
second_array=$first_array
```

Como já visto, `second_array` vai conter apenas o primeiro elemento de `first_array`, ou seja, `foo`.

Pode-se tentar, então, substituir essa atribuição pela indexação usando **aspas duplas** e `@`:

```bash
second_array="${array[@]}"
```

isso não funciona, pois o que se está atribuindo a `second_array` é apenas uma grande _string_ formada pelos elementos de `first_array`.

O que se faz, portanto, é inicializar um novo _array_ usando **parânteses**, e incluir nele todos os elemento do array original. Ou seja:

```bash
second_array( "${first_array[@]}" outro elemento ) # adicionei, ainda, outros dois elementos

for item in "${second_array[@]}"; do
    echo $item
done

# -> foo
# -> bar
# -> baz
# -> outro
# -> elemento
```

> [!TIP]
> Essa mesma adição de elementos (outro, elemento) a `second_array` poderia ser feita utilizando o operador `+=`.

```bash
second_array=("${first_array[@]}")
second_array += (outro elemento)
```

### Obtendo uma visão mais geral do _array_ usando `declare -p`

Pode-se usar o comando `declare` para obter uma visão do array, associando elementos a seus respectivos índices.

```bash
array=(foo bar baz)
declare -p array # -> typeset -a array=( foo bar baz )
```

### Obtendo comprimento do _array_

O comprimento do _array_ pode ser obtido usando o marcador `#`.

```bash
array=(foo bars baz)
echo "${#array[@]}" # -> 3
echo "${#array[1]}" # -> 4 (comprimento do elemento de índice 1)
```

## Associative _arrays_ (Arrays associativos)

Em _Bash_, arrays associativos são a estrutura de dados equivalentes a _HashMaps_ em Java, ou dicionários em Python, etc.

Ou seja, é basicamente uma estrutura de dados que associa chaves a valores.

### Criando arrays associativos

A criação de arrays associativos em _Bash_ se dá **exclusivamente** pela utilização do comando `declare`, mas dessa vez com a _flag_ `-A`.

```bash
declare -A arr
```

### Povoando array associativo

Para povoá-los, basta associar cada chave a um valor utilizando colchetes.

```bash
arr[foo]=1
arr[bar]=2
arr[baz]=3
```

### Obtendo valores

```bash
echo "$arr" # ->
echo "${arr}" # ->
echo "${arr[foo]}" # -> 1
echo "${arr["foo"]}" # -> 1
echo "${arr[@]}" # -> 1 2 3
echo "${arr[*]}" # -> 1 2 3
echo "${arr[fake]}" # ->
```

### Obtendo chaves

Para obter as chaves do array associativo, deve-se utilizar o símbolo `!`.

```bash
echo "${!arr[*]}" # -> foo bar baz
```

Importante notar que caso você deseje iterar pelas **chaves** do array associativo (em um laço `for`, por exemplo), será preciso utilizar **duplas aspas** junto com `@`.

```bash
for key in "${!arr[@]}"; do
    echo $key
done
# -> foo
# -> bar
# -> baz
```

Imagine que queremos agora, nesse mesmo laço, printar também os valores associados a cada chave. Podemos seguir com:

```bash
for key in "${!arr[@]}"; do
    value=${arr[key]}
    echo "Pair: $key=$value"
done
# -> Pair: foo=
# -> Pair: bar=
# -> Pair: baz=
```

Esse resultado ocorre pois `value=${arr[key]}` está buscando associar a variável `value` a o valor, no array associativo, ligado ao literal **key**. Como não existe essa chave na estrutura, nada é associado a `value`.

Assim, para que _value_ receba de fato o valor esperado deve-se utilizar `$`.

```bash
for key in "${!arr[@]}"; do
    value=${arr[$key]}
    echo "Pair: $key=$value"
done
# -> Pair: foo=1
# -> Pair: bar=2
# -> Pair: baz=3
```
