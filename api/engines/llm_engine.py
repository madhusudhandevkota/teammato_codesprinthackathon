# -*- coding: utf-8 -*-
import requests
import json

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

    def generate_insect_info(self,insect_name):
        prompt = (
            f"Provide a summary about the insect '{insect_name}'. Include information about its causes, harmful effects, and "
            f"recommended fertilizers to prevent it. Format the response in this way: "
            f"{{'summary': {{'summary_english': '<summary in English>', 'summary_nepali': '<summary in Nepali>'}}, "
            f"'followup_questions': {{'english': ['q1', 'q2', 'q3'], 'nepali': ['q1', 'q2', 'q3']}}}} response should be in json format no special characters or escape characters, plain text"
        )

        try:
            response = self.generate_response(prompt)
            # response = '''{
                            
            #                         "summary": {
            #                             "summary_english": "Fall armyworms are a type of insect that can cause significant damage to crops. They are native to the Americas, but have recently spread to other parts of the world, including Africa and Asia. Fall armyworms feed on a variety of plants, including corn, rice, and sorghum. They can cause severe damage to crops, leading to reduced yields and economic losses. There are a number of different ways to control fall armyworms, including the use of insecticides, biological control, and cultural practices. Recommended fertilizers to prevent fall armyworms include those that are high in nitrogen and phosphorus.",
            #                             "summary_nepali": "फॉल आर्मीवर्म एक प्रकारको किरा हो जसले बालीनालीमा उल्लेख्य क्षति पुर्‍याउन सक्छ। तिनीहरू अमेरिकाका मूल निवासी हुन्, तर हालै अफ्रिका र एसियासहित विश्वका अन्य भागहरूमा फैलिएका छन्। फॉल आर्मीवर्महरू मकै, धान र जुवारसहित विभिन्न प्रकारका बोटबिरुवाहरूमा खाने गर्छन्। तिनीहरूले बालीनालीमा गम्भीर क्षति पुर्‍याउन सक्छन्, जसले गर्दा उत्पादन घट्छ र आर्थिक नोक्सानी हुन्छ। फॉल आर्मीवर्महरूलाई नियन्त्रण गर्ने धेरै तरिकाहरू छन्, जसमा कीटनाशकहरूको प्रयोग, जैविक नियन्त्रण र सांस्कृतिक अभ्यासहरू समावेश छन्। फॉल आर्मीवर्महरूलाई रोक्न सिफारिस गरिएका मलहरूमा नाइट्रोजन र फस्फोरसमा उच्च हुनेहरू समावेश छन्।"
            #                         },
            #                         "followup_questions": {
            #                             "english": [
            #                                 "What are the symptoms of a fall armyworm infestation?",
            #                                 "How can I identify fall armyworms?"
            #                             ],
            #                             "nepali": [
            #                                 "फॉल आर्मीवर्म संक्रमणका लक्षणहरू के हुन्?",
            #                                 "म फॉल आर्मीवर्महरूलाई कसरी पहिचान गर्न सक्छु?"
            #                             ]
            #                         }
            #                 }'''
            print(response)
            response = eval(response)
            response_dict = {
                "insect" : insect_name,
                "message": response
            }
            response_json = json.dumps(response_dict, indent=4, ensure_ascii=False)
            return response_json
        except Exception as error:
            print('Error:', error)
            return None
    
    def generate_followup(self, insect, question):
        prompt = (
            f"The insect is'{insect}'. This is a followup question to a previous question about insect by a farmer. The current question is {question} answer fully only the answer no context along, include followup question. Format the response in this way: "
            f"{{'summary': {{'summary_english': '<summary in English>', 'summary_nepali': '<summary in Nepali>'}}, "
            f"'followup_questions': {{'english': ['q1', 'q2', 'q3], 'nepali': ['q1', 'q2', 'q3']}}}} response should be in json format no special characters or escape characters, plain text"
        )
        try:
            print("sending request")
            response = self.generate_response(prompt)
            # response = '''{
                            
            #                         "summary": {
            #                             "summary_english": "Change armyworms are a type of insect that can cause significant damage to crops. They are native to the Americas, but have recently spread to other parts of the world, including Africa and Asia. Fall armyworms feed on a variety of plants, including corn, rice, and sorghum. They can cause severe damage to crops, leading to reduced yields and economic losses. There are a number of different ways to control fall armyworms, including the use of insecticides, biological control, and cultural practices. Recommended fertilizers to prevent fall armyworms include those that are high in nitrogen and phosphorus.",
            #                             "summary_nepali": "CHange आर्मीवर्म एक प्रकारको किरा हो जसले बालीनालीमा उल्लेख्य क्षति पुर्‍याउन सक्छ। तिनीहरू अमेरिकाका मूल निवासी हुन्, तर हालै अफ्रिका र एसियासहित विश्वका अन्य भागहरूमा फैलिएका छन्। फॉल आर्मीवर्महरू मकै, धान र जुवारसहित विभिन्न प्रकारका बोटबिरुवाहरूमा खाने गर्छन्। तिनीहरूले बालीनालीमा गम्भीर क्षति पुर्‍याउन सक्छन्, जसले गर्दा उत्पादन घट्छ र आर्थिक नोक्सानी हुन्छ। फॉल आर्मीवर्महरूलाई नियन्त्रण गर्ने धेरै तरिकाहरू छन्, जसमा कीटनाशकहरूको प्रयोग, जैविक नियन्त्रण र सांस्कृतिक अभ्यासहरू समावेश छन्। फॉल आर्मीवर्महरूलाई रोक्न सिफारिस गरिएका मलहरूमा नाइट्रोजन र फस्फोरसमा उच्च हुनेहरू समावेश छन्।"
            #                         },
            #                         "followup_questions": {
            #                             "english": [
            #                                 "What are the types of infestation?",
            #                                 "How can I identify My Friend?"
            #                             ],
            #                             "nepali": [
            #                                 "फॉल आर्मीवर्म संक्रमणका लक्षणहरू के हुन्?",
            #                                 "म फॉल आर्मीवर्महरूलाई कसरी पहिचान गर्न सक्छु?"
            #                             ]
            #                         }
            #                 }'''
            print(response)
            response = eval(response)
            response_dict = {
                "insect" : insect,
                "message": response
            }
            response_json = json.dumps(response_dict, indent=4, ensure_ascii=False)
            return response_json
        except Exception as error:
            print('Error:', error)
            return None
        
