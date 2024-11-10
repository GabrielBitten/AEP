import pandas as pandas_lib
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import pickle

senha_data = pandas_lib.read_csv('data.csv', header=None, names=['senha', 'forca'])  
senhas = senha_data['senha']
forca = senha_data['forca']

senha_vectorizer = CountVectorizer(analyzer='char', ngram_range=(2, 4))
senhas_vetorizadas = senha_vectorizer.fit_transform(senhas)

X_train, X_test, y_train, y_test = train_test_split(senhas_vetorizadas, forca, test_size=0.2, random_state=42)

classificador_forca_senha = RandomForestClassifier()
classificador_forca_senha.fit(X_train, y_train)

predicoes_forca = classificador_forca_senha.predict(X_test)
print(accuracy_score(y_test, predicoes_forca))

with open('password_strength_model.pkl', 'wb') as arquivo_modelo:
    pickle.dump(classificador_forca_senha, arquivo_modelo)
with open('vectorizer.pkl', 'wb') as arquivo_vectorizer:
    pickle.dump(senha_vectorizer, arquivo_vectorizer)
