from flask import Flask, request, jsonify
import pickle
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

with open('password_strength_model.pkl', 'rb') as modelo_arquivo:
    modelo_forca_senha = pickle.load(modelo_arquivo)

with open('vectorizer.pkl', 'rb') as vetor_arquivo:
    vetor_senha = pickle.load(vetor_arquivo)


@app.route('/predict', methods=['POST'])
def prever_forca_senha():
    dados_recebidos = request.get_json()
    senha_recebida = dados_recebidos['senha']
    
    senha_transformada = vetor_senha.transform([senha_recebida])
    
    predicao_forca = modelo_forca_senha.predict(senha_transformada)
    nivel_forca = int(predicao_forca[0])

    return jsonify({'strength': nivel_forca})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
