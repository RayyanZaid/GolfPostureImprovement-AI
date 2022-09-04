from storage_manager import StorageManager
import os
import important
import glob
import shutil
from pathlib import Path


sm = StorageManager()

def send_images_example(v1, v2):
    important.kmeans(v1,v2) 
    
    public_urls = []
    #get the list of file store in the vid1 and vid2 directories

    
    os.chdir('../')
    vid1= os.listdir('images/vid1')
    vid2 = os.listdir('images/vid2')




    # # Get list of all files in a given directory sorted by name
    # dir1_name = 'images/vid1'
    # list_of_files1 = filter(os.path.isfile, glob.glob(dir1_name + '*'))
    # list_of_files1 = sorted(list_of_files1, key = os.path.getmtime)
    
    # dir2_name = 'images/vid2'
    # # Get list of all files in a given directory sorted by name
    # list_of_files2 = filter(os.path.isfile, glob.glob(dir2_name + '*'))
    # list_of_files2 = sorted(list_of_files2, key = os.path.getmtime)


    


    counter1 = 1
    counter2 = 5
    counter3 = 9
    # for i in range(len(vid1)):
    #     public_url1 = sm.upload_file(file_name=f'tennis/{vid1[i]}', local_path=f'images/vid1/{vid1[i]}')
    #     public_url2 = sm.upload_file(file_name=f'tennis/{vid2[i]}', local_path=f'images/vid2/{vid2[i]}')
    #     public_urls.append((public_url1,public_url2))
        
        # list_of_files1
        # list_of_files2
    
    for (file_path1, file_path2) in zip(vid1,vid2):
        os.chdir('images/vid1')
        public_url1 = sm.upload_file(file_name = f'tennis/{file_path1}' , local_path= file_path1)
        os.chdir('../vid2')
        public_url2 = sm.upload_file(file_name = f'tennis/{file_path2}' , local_path= file_path2)
        # public_url3 = sm.upload_file(file_name = f'tennis/{counter3}' , local_path= file_path3)
        counter1+=1
        counter2+=1
        os.chdir('../')
        os.chdir('../')
        public_urls.append((public_url1,public_url2))
    
    shutil.rmtree('coach')
    shutil.rmtree('student')
    # #deletes all the files in vid1
    folder = 'images/vid1'
    for filename in os.listdir(folder):
        file_path = os.path.join(folder, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))
    

    # #deletes all the files in vid2
    folder = 'images/vid2'
    for filename in os.listdir(folder):
        file_path = os.path.join(folder, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))
    
    folder = 'images/highlighted_differences'
    for filename in os.listdir(folder):
        file_path = os.path.join(folder, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))

            
    return public_urls

