import os
from flask import Flask, request,abort,jsonify
import ai_engine
import important

# flutter run --no-sound-null-safety

app = Flask(__name__)
app.config['UPLOAD_EXTENSIONS'] = ['.mp4']


@app.route('/analize', methods=['GET', 'POST']) # route for uploading image
def edit_video():
    uploaded_video = request.files.getlist("video1")[0]     
    uploaded_video2 = request.files.getlist("video2")[0]
    print(uploaded_video.filename)
    print(uploaded_video2.filename)
    video1_filename = uploaded_video.filename
    video2_filename = uploaded_video2.filename
    if video1_filename != '' and video2_filename != '':
        
        _, video_file_ext = os.path.splitext(video1_filename)
        _, image_file_ext = os.path.splitext(video2_filename)
        if image_file_ext not in app.config['UPLOAD_EXTENSIONS'] or video_file_ext not in app.config[
            'UPLOAD_EXTENSIONS']:
            abort(400)
        #Save video1 and video2
        
        uploaded_video.save(video1_filename)
        uploaded_video2.save(video2_filename)
        #You'll use the video1_path and video2_path to run the AI Engine
        # Call the function to run the AI Engine and returns the list of links to be access in the FrontEnd(Flutter APP)
        
        
        links = ai_engine.send_images_example(video1_filename,video2_filename)
        
        if(video1_filename != ''): 
            os.remove(video1_filename)
            os.remove(video2_filename)
        
        return jsonify(links)


if __name__ == "__main__":
    app.run(debug = True)