# Random-Album-Copy
Powershell script to copy random (music) albums when you need a random selection of specified size. It was made for copying a selection of my music collection to my mobile phone, but it should work with any kind of files.

I'll just leave it here in case someone will find it handy. It's a powershell script, undocumented and with variable names in both English and Czech. Read it on your own risk.

Currently it works only with collections with directory structure:
<pre>
/
  /Artist1/
    /Artist1/Album1/song1.mp3 # or any other format
    /Artist1/Album1/song2.mp3
    /Artist1/Album1/...
    /Artist2/Album2/...
  /Artist2/
    /Artist2/Album1/...
    /Artist2/Album2/...
  /...
</pre>

It will take a random selection of your albums trying to get close to your preferred total size and copy them to the destination folder.

Usage: <code>./randomAlbum.ps1 sourceDirectory targetDirectory sizeInMB</code>

Tested in Windows 8, 8.1 and 10.
