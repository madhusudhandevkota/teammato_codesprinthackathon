# -*- coding: utf-8 -*-
import requests
import json
import re

class llm_service:
    def __init__(self):
        self.api_url = 'https://api.edenai.run/v2/text/generation'
        self.api_key = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNTgwODZiMWYtNmY1OC00MTMwLTk2MjItZGIwYTIyOTFhNzgyIiwidHlwZSI6ImFwaV90b2tlbiJ9.-4iEcb0zwQg5pB4EHFyI2hVMANgCgE2KgXqiH1VLsfk'
        
    def generate_response(self,prompt):
        try:
            request_data = {
                'text': prompt,
                'numOutputs': 1,
                'maxTokens': 150,  
                'apiKey': self.api_key,
                'providers': 'google'
            }

            response = requests.post(self.api_url, json=request_data, headers={
                'Content-Type': 'application/json',
                'Authorization': f'Bearer {self.api_key}'
            })

            if response.status_code != 200:
                raise Exception(f'Request failed with status {response.status_code}')

            data = response.json()
            generated_text = data.get('google', {}).get('generated_text', '')
            print(data)
            return generated_text

        except Exception as error:
            print('Error:', error)
            return None

    def _clean_llm_response(self, response):
        if not response:
            return None
        # Remove markdown code block and json label if present
        response = response.strip()
        response = re.sub(r'^```json\n', '', response)
        response = re.sub(r'^```', '', response)
        response = re.sub(r'```$', '', response)
        return response.strip()

    def generate_insect_info(self,insect_name):
        prompt = (
            f"Provide a summary about the insect '{insect_name}'. Include information about its causes, harmful effects, and "
            f"recommended fertilizers to prevent it. Format the response in this way: "
            f"{{'summary': {{'summary_english': '<summary in English>', 'summary_nepali': '<summary in Nepali>'}}, "
            f"'followup_questions': {{'english': ['q1', 'q2', 'q3'], 'nepali': ['q1', 'q2', 'q3']}}}} response should be in json format no special characters or escape characters, plain text"
        )

        try:
            response = self.generate_response(prompt)
            response = self._clean_llm_response(response)
            try:
                response_dict = json.loads(response)
            except Exception as error:
                print('Error parsing JSON:', error)
                return json.dumps({"error": "Invalid response from LLM"}, ensure_ascii=False)
            response_dict = {
                "insect" : insect_name,
                "message": response_dict
            }
            response_json = json.dumps(response_dict, indent=4, ensure_ascii=False)
            return response_json
        except Exception as error:
            print('Error:', error)
            return json.dumps({"error": "Internal server error"}, ensure_ascii=False)
    
    def generate_followup(self, insect, question):
        prompt = (
            f"The insect is'{insect}'. This is a followup question to a previous question about insect by a farmer. The current question is {question} answer fully only the answer no context along, include followup question. Format the response in this way: "
            f"{{'summary': {{'summary_english': '<summary in English>', 'summary_nepali': '<summary in Nepali>'}}, "
            f"'followup_questions': {{'english': ['q1', 'q2', 'q3], 'nepali': ['q1', 'q2', 'q3']}}}} response should be in json format no special characters or escape characters, plain text"
        )
        try:
            print("sending request")
            response = self.generate_response(prompt)
            response = self._clean_llm_response(response)
            try:
                response_dict = json.loads(response)
            except Exception as error:
                print('Error parsing JSON:', error)
                return json.dumps({"error": "Invalid response from LLM"}, ensure_ascii=False)
            response_dict = {
                "insect" : insect,
                "message": response_dict
            }
            response_json = json.dumps(response_dict, indent=4, ensure_ascii=False)
            return response_json
        except Exception as error:
            print('Error:', error)
            return json.dumps({"error": "Internal server error"}, ensure_ascii=False)
        
