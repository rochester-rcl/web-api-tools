## A Comprehensive Set of Tools for the Processing Humanities Multimedia Course at DHSI

#### Tools
* ffmpeg [examples](#ffmpeg-examples)
* imagemagick / ghostscript [examples](#imagemagick-examples)
* sox [examples](#sox-examples)

#### Python (3.7) Modules
* beautifulsoup4
* internetarchive 
* scipy
* twitch-python
* twitter-scraper
* scrapy / shub

### How to Use
Clone or download the repository. If downloaded, unzip / extract it.

Change directories into the repository folder:

`cd /path/to/web-api-tools`

where `/path/to/web-api-tools` is the path to the repository folder.

To run:

`docker-compose run web_api_tools`

For convenience the repository directory is mounted to the `/working` directory in the container. You can move files and sub-folders into the repository folder if you wish to manipulate them, or save new files to the `/working` directory to persist them onto the host machine. You can also mount another volume with the following command:

`docker-compose run -v /path/to/new/dir:/my-dir`

where `/path/to/new/dir` is the absolute path to the folder you want to mount on the host machine (hint - you can drag and drop the folder into your shell to get the absolute path) and `/my-dir` is the absolute path mounted in the container.

### FFMPEG Examples

#### 1. Converting Files

	#Using default settings w/ default codec library
	ffmpeg -i /path/to/input /path/to/output

	#Specifying a codec library
	ffmpeg -i /path/to/input -c:v libx264 /path/to/output

	#Using constant rate factor (visually lossless)
	ffmpeg -i /path/to/input -c:v libx264 -crf 18 /path/to/output


#### 2. Transcoding Files for Streaming

	#Creating a webm file
	ffmpeg -i /path/to/input -c:v libvpx -crf 23 -b:v 1M -c:a libvorbis /path/to/output.webm #where -b:v is the max bitrate

	#Creating an H.264 file
	ffmpeg -i /path/to/input -c:v libx264 -crf 23 -strict -2 -pix_fmt yuv420p -movflags faststart /path/to/output.mp4

#### 3. Stream Mapping

	#Copy video stream and transcode audio stream
	ffmpeg -i /path/to/input -c:v copy -c:a aac -strict -2 /path/to/output.mp4

	#Remove audio
	ffmpeg -i /path/to/input -c:v copy -an /path/to/output.mp4 #audio null

	#Export audio and video to separate files
	ffmpeg -i /path/to/input -map 0:0 /path/to/output.mp4 -map 0:1 /path/to/output.wav #defaults to 16 bit pcm

#### 4. Time-Based Commands

	#Export sections of a video
	ffmpeg -i /path/to/input -ss 00:00:00 -to 00:00:30 -c:v libx264 /path/to/output #export first 30 seconds of a video

	#Export a single frame as an image
	ffmpeg -i /path/to/input -ss 00:00:14.435 -vframes 1 /path/to/output.png

	#Altering framerates / time bases
	ffmpeg -i /path/to/input -c:v libx264 -vf setpts=0.5*PTS /path/to/output.mp4

	# Alters the actual presentation time stamp so that the playback is 2x faster

	ffmpeg -i /path/to/input -c:v libx264 -vf setpts=2.0*PTS /path/to/output.mp4

	# Alters the presentation time stamp so the playback is 2x slower

#### 5. Image Manipulation

	#Scale
	ffmpeg -i /path/to/input -c:v libx264 -vf scale=1920:1080 /path/to/output.mp4 #w:h

	#Crop
	ffmpeg -i /path/to/input -c:v libx264 -vf crop=100:100:0:0 /path/to/output.mp4
	# will crop a video to 100x100 square starting in the top left corner (crop=w:h:x_start:y_start)

	#Chaining filters
	ffmpeg -i /path/to/input -c:v libx264 -vf scale=100:100,crop=100:100:0:0 /path/to/output.mp4

#### 6. Batch Processing

	#Batch process files
	for x in *.avi; do
		ffmpeg -i $x -c:v libx264 -strict -2 ${x%.avi}.mp4;
	done

## ImageMagick Examples

#### 1. Converting Files
Basic conversion
```
convert /path/to/image.jpg /path/to/image.png
```
Setting the quality
```
convert /path/to/image.jpg -quality 75 /path/to/image.png
```

#### 2. Image Manipulation

Rotating images (rotates 90deg clockwise)
```
convert /path/to/image.jpg -rotate 90 /path/to/image.png
```

Resizing  / scaling images (resizes to 50% of original size)
```
convert /path/to/image.jpg -resize 50 /path/to/image.png
```

Cropping images (crops 100px x 100px square from top left corner)
```
convert /path/to/image.jpg -crop 100x100+0+0 /path/to/image.png
```

#### 3. Image Filtering

Denoise an image (with an aggression level of 5)
```
convert /path/to/image.jpg -noise 5 /path/to/image.png
```

Sharpen an image (with an aggression level of 5)
```
convert /path/to/image.jpg -sharpen 5 /path/to/image.png
```

Add contrast to an image
```
convert /path/to/image.jpg -contrast /path/to/image.png
```

#### 4. Image Analysis
Display technical metadata
```
identify /path/to/image.jpg
```
Produce a histogram
```
convert /path/to/image.jpg histogram:/path/to/image.png
```

## Sox Examples

#### 1. Converting Files
Basic conversion
```
sox /path/to/audio.wav /path/to/audio.mp3
```
Setting the sample rate (48kHz)
```
sox -r 48000 /path/to/audio.wav /path/to/audio.mp3
```
Convert stereo to mono
```
sox -c 1 /path/to/audio.wav /path/to/audio.mp3
```

#### 2. Manipulating Files
Increase the volume of a file (2x louder)
```
sox -v 2.0 /path/to/audio.wav /path/to/audio.mp3
```
Decrease the volume of a file (2x quieter)
```
sox -v -0.5 /path/to/audio.wav /path/to/audio.mp3
```
Trim a file (trims a 30 second clip from the beginning of a file )
```
sox /path/to/audio.wav /path/to/audio.mp3 trim 0 30
```
Reverse an audio file
```
sox /path/to/audio.wav /path/to/audio.mp3 reverse
```
Speed up an audio file (2x faster)
```
sox /path/to/audio.wav /path/to/audio.mp3 speed 2.0
```
Speed up an audio file (2x slower)
```
sox /path/to/audio.wav /path/to/audio.mp3 speed 0.5
```

#### 3. Audio Filtering and Effects
Apply a low pass filter (everything below this frequency "passes" through)
```
sox /path/to/audio.wav /path/to/audio.mp3 lowpass 500
```
Apply a high pass filter (everything above this frequency "passes" through)
```
sox /path/to/audio.wav /path/to/audio.mp3 highpass 500
```
Sox has several effects you can apply (chorus, flanger, echo). The syntax is like this:
```
sox /path/to/audio.wav /path/to/audio.mp3 [EFFECT NAME] [EFFECT PARAMETERS]
```
You can find them here: http://sox.sourceforge.net/sox.html

#### 4. Analysis
Get some technical metadata on the file
```
sox --i /path/to/audio.wav
```
Produce a spectrogram of your file
```
sox /path/to/audio.wav -n spectrogram -r -o /path/to/image.png
```