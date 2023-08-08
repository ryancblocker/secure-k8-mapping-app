import json
from elasticsearch import Elasticsearch

# Load JSON file
with open('/home/cassidy/Videos/kube-spring-keycloak-app/initial/src/main/resources/static/bulk.json') as file:
    data = file.read()

# Parse JSON data
records = data.strip().split('\n')
actions = []
for i in range(0, len(records), 2):
    index_meta = json.loads(records[i])
    document = json.loads(records[i + 1])
    actions.append(index_meta)
    actions.append(document)

# Update Elasticsearch index
es = Elasticsearch('http://localhost:9200')
response = es.bulk(index='test', body=actions)

# Print response
print(response)
