# IMG-downloader

During a period of magazine advertising, publishers offered a copy of the magazine for free on an online reading site: [Calaméo](https://calameo.com). Unfortunately, if the person uploading the file to the site does not offer the download, the document cannot be read offline.

It is by starting from this principle and by failing with the other proposed methods, that I decided to build a shell ("*and a batch script*" -- in active construction) in order to:
- download all the images of the file proposed for reading
- merge the images in a PDF file / compress the images in a ZIP file (*windows version*)
- allow the final PDF/ZIP to be downloaded from any device (by FTP and deposit on a free server)
- **all in one action!**

> **In the end, in about 1 min for ~40 images (pages), you get your file ready to view and store wherever you want!**

# 3 ways to do (*by order of preference*)
- **[UNIX](#unix)** : see all the details delow
- **WINDOWS** (1) : use a **virtual machine** to run the above UNIX script ([TUTORIAL link](https://medium.com/platform-engineer/how-to-install-debian-linux-on-virtualbox-with-guest-additions-778afa0ee7e0)) -- **other simpler solutions will arrive**
- **WINDOWS** (2) : A command line user version is now available but it is definitely not finalized and just run the script **as administrator** and answer the questions. *This script only downloads images from magazines and can send it to a server but does not merge them into PDF*.

---

## UNIX
### Download the script
Here are the packages that will be installed from the script (dependencies are not listed): `img2pdf` and `rename`.
```{bash}
curl -o "down_img.sh" https://framagit.org/downloader-s/img-downloader/-/raw/master/down_img.sh
chmod u+x down_img.sh
```
### Run the code
"Basically" and interactively. Simply run the script and answer the questions.
```{bash}
./down_img.sh
```
### Update the script
It may be necessary in the future to update this script : **it is important to do this regularly in order to keep a stable version and take advantage of all the features.** To do this, simply re-download the script from step **[Download the script](#download-the-script)**.

---

*Ressources used* :
- [Git](https://github.com/git/git) / Package
- [img2pdf](https://gitlab.mister-muffin.de/josch/img2pdf) / Package
- [curl](https://github.com/curl/curl) / Package
- rename / Package
- [Script to the server](https://forum.ubuntu-fr.org/viewtopic.php?id=120246) / Source
- [Link to the free server](http://dl.free.fr) / Server