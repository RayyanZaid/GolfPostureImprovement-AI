import firebase_admin
from firebase_admin import credentials, storage

class StorageManager:
    def __init__(self):
        self.bucket_name = 'plzwork-16f0a.appspot.com'
        self.fb_cred = 'creds/fbkey.json'
        cred = credentials.Certificate(self.fb_cred)
        firebase_admin.initialize_app(cred, {
            'storageBucket': self.bucket_name
        })

    def exists_on_cloud(self, file_name):
        bucket = storage.bucket()
        blob = bucket.blob(file_name)
        if blob.exists():
            return blob.public_url
        else:
            return False

    def upload_file(self, file_name, local_path):
        bucket = storage.bucket()
        blob = bucket.blob(file_name)

        
        outfile = local_path
        blob.upload_from_filename(outfile)
        with open(outfile, 'rb') as fp:
            blob.upload_from_file(fp)
        print('This file is uploaded to cloud.')
        blob.make_public()
        return blob.public_url