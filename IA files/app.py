from flask import Flask, request, jsonify
import pickle
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  

with open('password_strength_model.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

with open('vectorizer.pkl', 'rb') as vec_file:
    vectorizer = pickle.load(vec_file)


@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    senha = data['senha']
    

    senha_vec = vectorizer.transform([senha])
    
  
    prediction = model.predict(senha_vec)
    strength = int(prediction[0]) 

    return jsonify({'strength': strength})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
