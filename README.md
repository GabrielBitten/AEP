# Verificador de Senha

Este projeto é um verificador de força de senhas que utiliza um modelo de machine learning para avaliar a força de senhas fornecidas pelo usuário. O sistema classifica as senhas em três níveis de segurança: fraca, média e forte.

## Tecnologias Utilizadas

Python: Para desenvolvimento da API que realiza a análise das senhas.

Flask: Framework para construção da API.

Machine Learning: Algoritmo treinado para classificar a força das senhas.

Flutter: Framework utilizado para a criação da interface do usuário.


## Pré-requisitos

Antes de executar o projeto, você precisa ter os seguintes arquivos:

1. **`password_strength_model.pkl`** 
2. **`outro_arquivo.ext`** 

- Os dois arquivos são gerados pelo ia.py localizado na pasta IA files. Devido ao tamanho dos arquivos, eles estão disponíveis para download a partir do Google Drive.

## Como obter os arquivos

Os arquivos podem ser baixados do Google Drive. Utilize os seguintes links:

- password_strength_model.pkl
- vectorizer.pkl

https://drive.google.com/drive/folders/18YNaDu1la1tk5JTvHFMl9RFehDgaWra5?hl=pt-br

Após o download, coloque os arquivos na pasta IA files do seu projeto.

## Instruções de uso

### Configuração Inicial
1. Baixe os arquivos mencionados anteriormente e coloque-os na pasta iasenhas.
2. Abra o arquivo verificador_senha.dart dentro da classe verificadorSenha.
3. No método checkPasswordStrength, substitua o IP pelo IP do seu PC para que a aplicação consiga se comunicar corretamente.

### Instalação das dependências
Execute o seguinte comando para instalar as dependências

1. Dentro da pasta do projeto: flutter pub get

2. Dentro da pasta IA files: python app.py

3. Dentro da pasta do projeto: flutter run

4. Execute os testes na pasta IA files: python -m unittest test_api.py

## Endpoints da API
/predict [POST]

Descrição: Este endpoint recebe uma senha como entrada e retorna um valor indicando a força da senha. O valor retornado pode ser:

0: Senha Fraca

1: Senha Média

2: Senha Forte

Exemplo de Requisição:

{
  "senha": "teste23452"
}

Exemplo de Resposta:

{
  "strength": 1
}

## Testes
O projeto inclui testes automatizados para verificar se a API está funcionando corretamente. Para executar os testes, use o comando:

python -m unittest testes/test_api.py

Os testes verificam diferentes cenários de senhas para garantir que o modelo de machine learning está classificando corretamente as senhas.

Testes:

Senha Vazia: Verificar a resposta da API quando uma senha em branco é enviada.

Senha Fraca: Testa senhas simples e comuns.

Senha Média: Testa senhas com combinações mais complexas.

Senha Forte: Testa senhas com caracteres especiais, letras maiúsculas, minúsculas e números.

Teste de Grande Quantidade de Requisições: Testar a capacidade da API de lidar com várias requisições simultâneas.

Teste de Tempo de Resposta: Verificar se a API responde dentro de um tempo aceitável.




