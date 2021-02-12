## A Comprehensive Set of Tools for the Processing Humanities Multimedia Course at DHSI

#### Python (3.9) Modules
* [beautifulsoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
* [internetarchive](https://archive.org/services/docs/api/internetarchive/)
* [scipy](https://docs.scipy.org/doc/)
* [twitch-python](https://pypi.org/project/twitch-python/)
* [twitter-scraper](https://pypi.org/project/twitter-scraper/)
* [praw](https://praw.readthedocs.io/en/latest/)
* [scrapy / shub](https://scrapy.org/)

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

To run local scripts, create new python files in the repository directory, for example, a file called `test.py` that will be mounted in the container at `/working/test.py`:

```python
import twitch

helix = twitch.Helix('client-id', 'client-secret')
for user in helix.users(['sodapoppin', 'reckful', 24250859]):
    print(user.display_name)
```

To run the script:

`docker-compose run web_api_tools /working/test.py`

An interactive Python shell can also be opened by running:

`docker-compose run web_api_tools python`
