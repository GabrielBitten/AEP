# Verificador de Senha

Este projeto é um verificador de força de senhas que utiliza um modelo de machine learning para avaliar a força de senhas fornecidas pelo usuário.

## Pré-requisitos

Antes de executar o projeto, você precisa ter os seguintes arquivos:

1. **`password_strength_model.pkl`** 
2. **`outro_arquivo.ext`** 

- Os dois arquivos são gerados pelo ia.py localizado na pasta IA files, porém devido ao seu tamanho coloquei eles em um drive.

## Como obter os arquivos

Os arquivos podem ser baixados do Google Drive. Utilize os seguintes links:

- password_strength_model.pkl
- vectorizer.pkl

https://drive.google.com/drive/folders/18YNaDu1la1tk5JTvHFMl9RFehDgaWra5?hl=pt-br

## Instruções de uso

1. Após baixar os arquivos, coloque-os na pasta `iasenhas` do seu projeto.

2. Dentro da classe verificador_senha, no método checkPasswordStrength, substitua o IP pelo IP do seu PC

3. Use o comando: flutter pub get

4. Use o comando: python app.py

5. Use o comando: flutter run

6. Execute os testes com o comando: python -m unittest test_api.py 


