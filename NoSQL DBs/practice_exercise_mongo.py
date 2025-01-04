from pymongo import MongoClient
user = 'root'
password = 'MTU2NjYtc2FsaW1v' # CHANGE THIS TO THE PASSWORD YOU NOTED IN THE EARLIER EXCERCISE - 2
host='localhost'
#create the connection url
connecturl = "mongodb://{}:{}@{}:27017/?authSource=admin".format(user,password,host)

# connect to mongodb server
print("Connecting to mongodb server")
connection = MongoClient(connecturl)

# select the 'training' database 

db = connection.training

# select the 'python' collection 

collection = db.mongodb_glossary

# create a sample document

doc_1 = {"database":"a database contains collections"}
doc_2 = {"collection":"a collection stores the documents"}
doc_3 = {"document":"a document contains the data in the form of key value pairs."}

# insert a sample document

print("Inserting a document into collection.")
db.collection.insert_one(doc_1)
db.collection.insert_one(doc_2)
db.collection.insert_one(doc_3)

# query for all documents in 'training' database and 'python' collection

docs = db.collection.find()

print("Printing the documents in the collection.")

for document in docs:
    print(document)

# close the server connecton
print("Closing the connection.")
connection.close()