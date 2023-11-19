import pandas as pd
import requests

class Data:
    def __init__(self, tags, name, link):
        self.tags = tags
        self.name = name
        self.link = link

    def to_json(self):
         return {
               "tags": self.tags,
               "name": self.name,
               "link": self.link
         }

# Function to parse data from Excel file into a list of Data objects
def parse_excel_to_data_list(excel_file_path, sheet_name):
    df = pd.read_excel(excel_file_path, sheet_name=sheet_name, header=None)
    
    data_list = []

    # Extract data from columns
    for column in df.columns[2:]:
        name = df.iloc[1, column]
        link = df.iloc[2, column]
        tags = df.iloc[4:30, column].dropna().tolist()

        data_list.append(Data(tags, name, link)) 

    return data_list

# Function to aggregate data
def publish_data(data_list: list):
    url = "http://localhost:8080/recommendations/create"

    for data in data_list:
         payload = {
            "tags": data.tags,
            "name": data.name,
            "link": data.link
         }
   
         response = requests.request("POST", url, json=payload)
   
         print(response.status_code, response.text)

# Example usage
excel_file_path = './SensiTapeData.xlsx'
data_list = parse_excel_to_data_list(excel_file_path, "Sheet2")
publish_data(data_list)