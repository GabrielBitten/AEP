import unittest
from app import app 

class TestPasswordStrengthAPI(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.client = app.test_client() 

    def teste_sem_senha(self):     
        response = self.client.post('/predict', json={'senha': ''})
        data = response.get_json()
        self.assertEqual(response.status_code, 200)
        self.assertIn('strength', data)
        self.assertEqual(data['strength'], 0)      

    def teste_senha_fraca(self):     
        response = self.client.post('/predict', json={'senha': 'teste2'})
        data = response.get_json()
        self.assertEqual(response.status_code, 200)
        self.assertIn('strength', data)
        self.assertEqual(data['strength'], 0)  

    def teste_senha_mediana(self):      
        response = self.client.post('/predict', json={'senha': 'teste23452@'})
        data = response.get_json()
        self.assertEqual(response.status_code, 200)
        self.assertIn('strength', data)
        self.assertEqual(data['strength'], 1) 

    def teste_senha_forte(self):      
        response = self.client.post('/predict', json={'senha': 'teste23452@gmail.com'})
        data = response.get_json()
        self.assertEqual(response.status_code, 200)
        self.assertIn('strength', data)
        self.assertEqual(data['strength'], 2)     

    def teste_grande_quantidade_rquisicoes(self):
     for i in range(100):  
        response = self.client.post('/predict', json={'senha': 'teste123'})
        data = response.get_json()
        self.assertEqual(response.status_code, 200)
        self.assertIn('strength', data)

    def teste_tempo_resposta(self):
     import time
     start_time = time.time()
     response = self.client.post('/predict', json={'senha': 'teste123'})
     end_time = time.time()
     self.assertEqual(response.status_code, 200)
     self.assertLess(end_time - start_time, 2) 
     
if __name__ == '__main__':
    unittest.main()
